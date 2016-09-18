module AutomationObject
  module Driver
    class Base
      attr_accessor :adapter

      def initialize(adapter_object, *_args)
        self.adapter = adapter_object
      end
    end
  end
end
