# frozen_string_literal: true

# Require parent class
require_relative 'composite'

module AutomationObject
  module BluePrint
    module HashAdapter
      # View composite
      class View < Composite
        # Creation hooks
        before_create :merge_views
        before_create :automatic_modal_changes

        # Relationships
        has_one :load, interface: Hook
        has_one :accept, interface: Hook
        has_one :dismiss, interface: Hook

        has_many :modals, interface: Modal
        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash

        # Validations
        validates_keys allowed_keys: %i[automatic_onload_modals automatic_screen_changes elements element_arrays
                                        element_groups element_hashes included_views load modals]

        validates :automatic_onload_modals, instance_of: Array, modal_presence_of: true
        validates :automatic_screen_changes, instance_of: Array, screen_presence_of: true

        validates :elements, instance_of: Hash
        validates :element_arrays, instance_of: Hash
        validates :element_groups, instance_of: Hash
        validates :element_hashes, instance_of: Hash

        validates :included_views, instance_of: Array, view_presence_of: true

        validates :load, instance_of: Hash

        validates :modals, instance_of: Hash

        # @return [Array<AutomaticModalChange>] array of AutomaticModalChange that are defined under the screen
        def automatic_modal_changes
          return @automatic_modal_changes if defined? @automatic_modal_changes

          children = hash[:automatic_modal_changes]
          children = children.is_a?(Array) ? children : []
          @automatic_modal_changes = create_array_children(:automatic_modal_changes, children,
                                                           interface: AutomaticModalChange,
                                                           location: location + '[automatic_modal_change]')

          @automatic_modal_changes
        end

        # @return [Array<Symbol>] array of screens where screen can automatically change to
        def automatic_screen_changes
          screen_array = hash[:automatic_screen_changes] ||= []
          screen_array.map(&:to_sym)
        end

        # @return [Array<Symbol>] array of views this can has
        def included_views
          included_views_array = hash[:included_views] ||= []
          included_views_array.map(&:to_sym)
        end

        # Method to take views and merge into this composite
        def merge_views
          top_hash = top.hash

          return unless top_hash.is_a?(Hash)
          return unless top_hash[:views].is_a?(Hash)

          top_view_hash = top_hash[:views]

          included_views.each do |included_view|
            next unless top_view_hash[included_view].is_a?(Hash)

            self.hash = hash.deep_merge(top_view_hash[included_view])
          end
        end
      end
    end
  end
end
