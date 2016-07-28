require_relative '../../../../lib/automation_object/helpers/composite'

module AutomationObject
  module BluePrint
    module Composite
      #This composite namespace is the interface contract for the rest of the application to rely on
      #Adapters should implement the same classes and methods as the composite to achieve reliability
      #with the rest of the application
      class Base
        attr_accessor :adapter

        def initialize(adapter_namespace, *args)
          #Get which namespace to use, and add adapter to self
          adapter_const = adapter_namespace.const_get(self.class.name.split('::').last)
          self.adapter = adapter_const.new(args)
        end
      end
    end
  end
end