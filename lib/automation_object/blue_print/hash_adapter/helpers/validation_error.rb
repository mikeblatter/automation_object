# frozen_string_literal: true
module AutomationObject
  module BluePrint
    module HashAdapter
      # ValidatorError exception class
      # Allows for multiple errors at one time to allow for better debugging
      class ValidationError < RuntimeError
        attr_accessor :errors

        # @param errors [Array, String] pass validation error(s) in, class can handle singular or multiple
        def initialize(errors)
          @errors = errors.is_a?(Array) ? errors : [errors]
        end

        # @return [String] returns full error message
        def message
          message = "\nBluePrint::HashAdapter composite validation failed for the following errors:\n"
          @errors.each do |error|
            message << "     - #{error}\n"
          end

          message + "\n"
        end
      end
    end
  end
end
