# Require parent class
require_relative 'composite'

module AutomationObject
  module BluePrint
    module HashAdapter
      # View composite
      class View < Composite
        # Creation hooks
        before_create :merge_views
        before_create :automatic_onload_modals

        # Relationships
        has_one :load, interface: Hook
        has_one :accept, interface: Hook
        has_one :dismiss, interface: Hook

        has_many :modals, interface: Modal
        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash

        # Validations
        validates_keys allowed_keys: [:automatic_onload_modals, :automatic_screen_changes, :elements, :element_arrays,
                                      :element_groups, :element_hashes, :included_views, :load, :modals]

        validates :automatic_onload_modals, instance_of: Array, modal_presence_of: true
        validates :automatic_screen_changes, instance_of: Array, screen_presence_of: true

        validates :elements, instance_of: Hash
        validates :element_arrays, instance_of: Hash
        validates :element_groups, instance_of: Hash
        validates :element_hashes, instance_of: Hash

        validates :included_views, instance_of: Array, view_presence_of: true

        validates :load, instance_of: Hash

        validates :modals, instance_of: Hash

        # @return [Array<AutomaticOnloadModal>] array of AutomaticOnloadModal that are defined under the screen
        def automatic_onload_modals
          return @automatic_onload_modals if defined? @automatic_onload_modals

          children = self.hash[:automatic_onload_modals]
          children = (children.is_a?(Array)) ? children : Array.new
          @automatic_onload_modals = self.create_array_children(:automatic_onload_modals, children,
                                                                {interface: AutomaticOnloadModal,
                                                                 location: self.location + '[automatic_onload_modals]'})

          return @automatic_onload_modals
        end

        # @return [Array<Symbol>] array of screens where screen can automatically change to
        def automatic_screen_changes
          screen_array = self.hash[:automatic_screen_changes] ||= Array.new
          screen_array.map { |screen| screen.to_sym }
        end

        # @return [Array<Symbol>] array of views this can has
        def included_views
          included_views_array = self.hash[:included_views] ||= Array.new
          included_views_array.map { |view| view.to_sym }
        end

        # Method to take views and merge into this composite
        def merge_views
          top_hash = self.top.hash

          return unless top_hash.is_a?(Hash)
          return unless top_hash[:views].is_a?(Hash)
          top_view_hash = top_hash[:views]

          self.included_views.each { |included_view|
            next unless top_view_hash[included_view].is_a?(Hash)
            self.hash = self.hash.deep_merge(top_view_hash[included_view])
          }
        end
      end
    end
  end
end
