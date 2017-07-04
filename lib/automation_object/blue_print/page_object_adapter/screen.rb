# frozen_string_literal: true

require_relative 'composite'

require_relative 'modal'
require_relative 'hook'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Screen composite
      class Screen < Composite
        # Relationships
        has_one :load, interface: Hook
        has_one :accept, interface: Hook
        has_one :dismiss, interface: Hook

        has_many :modals, interface: Modal
        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash
      end
    end
  end
end
