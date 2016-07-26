require_relative '../../../../lib/automation_object/helpers/composite'

module AutomationObject
  module BluePrint
    module Composite
      class Base < AutomationObject::Composite
        attr_accessor :adapter_namespace

        def initialize(adapter_namespace, *args)
          #Get which namespace to use, and extend
          adapter_namespace = adapter_namespace.const_get(self.class.name.split('::').last)
          extend adapter_namespace

          super(*args)
        end
      end
    end
  end
end