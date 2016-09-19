# frozen_string_literal: true
module AutomationObject
  module Driver
    # Base class for driver and element adapter interface
    class Base
      attr_accessor :adapter

      def initialize(adapter_object, *_args)
        self.adapter = adapter_object
      end
    end
  end
end
