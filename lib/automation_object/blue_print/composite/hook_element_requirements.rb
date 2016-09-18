# Require parent class
require_relative 'base'

require_relative 'element'

module AutomationObject
  module BluePrint
    module Composite
      # HookElementRequirements composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class HookElementRequirements < Base
        # Get the order to run the hook in
        # @return [Array<Symbol>] list of hook methods to run in given order
        def hook_order
          adapter.hook_order
        end

        # Get element requirement
        # @param name [Symbol] name of requested requirement
        def requirement(name)
          adapter.requirement(name)
        end

        # Get name of the element
        # @return [Symbol] name of element
        def element_name
          adapter.element_name
        end

        # Convience for getting element blueprints
        # @return [AutomationObject::BluePrint::Composite::Element]
        def element_blueprints(composite_object = nil)
          adapter.element_blueprints(composite_object)
        end
      end
    end
  end
end
