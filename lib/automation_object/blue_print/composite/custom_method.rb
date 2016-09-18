# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # CustomMethod composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class CustomMethod < Base
        # @return [Symbol, nil]
        def element_method
          self.adapter.element_method
        end

        # @return [String, nil]
        def evaluate
          self.adapter.evaluate
        end
      end
    end
  end
end
