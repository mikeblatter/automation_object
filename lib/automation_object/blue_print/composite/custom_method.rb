# frozen_string_literal: true
# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # CustomMethod composite class
      class CustomMethod < Base
        # @return [Symbol, nil]
        def element_method
          adapter.element_method
        end

        # @return [String, nil]
        def evaluate
          adapter.evaluate
        end
      end
    end
  end
end
