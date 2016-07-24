require_relative 'composite'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module State
    module BluePrintAdapter
      #TODO: refactor to container
      class Modal < AutomationObject::State::BluePrintAdapter::Composite
        has_one :load, interface: Hook

        #Children for this composite
        has_many :modals, interface: Modal

        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash

        attr_accessor :active
        # @return [Boolean] screen is active or not
        def active
          return @active ||= false
        end
      end
    end
  end
end