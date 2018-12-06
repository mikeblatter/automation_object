# frozen_string_literal: true

# Require parent class
require_relative 'composite'

# Require child classes
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'
require_relative 'hook'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Modal-level composite, ActiveRecord style composite implementation inheriting from Composite
      class Modal < Composite
        # Relationships
        has_one :load, interface: Hook

        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash

        # Validations
        validates_keys allowed_keys: %i[load elements element_arrays element_hashes]

        validates :load, instance_of: Hash
        validates :elements, instance_of: Hash
        validates :element_arrays, instance_of: Hash
        validates :element_hashes, instance_of: Hash

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
