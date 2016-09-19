# frozen_string_literal: true
require_relative '../../../../lib/automation_object/helpers/composite'

module AutomationObject
  module BluePrint
    module Composite
      # This composite namespace is the interface contract for the rest of the application to rely on
      # Adapters should implement the same classes and methods as the composite to achieve reliability
      # with the rest of the application
      class Base
        attr_accessor :adapter

        def initialize(adapter_object)
          self.adapter = adapter_object
        end
      end
    end
  end
end
