module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        #ValidatorError exception class
        #Allows for multiple errors at one time to allow for better debugging
        class ValidationError < Exception
          attr_accessor :errors

          # @param errors [Array, String] pass validation error(s) in, class can handle singular or multiple
          def initialize(errors)
            @errors = (errors.is_a?(Array)) ? errors : [errors]
          end

          # @return [String] returns full error message
          def message
            message = "\nBluePrint::HashAdapter composite validation failed for the following errors:\n"
            @errors.each { |error|
              message << "     - #{error}\n"
            }

            return message + "\n"
          end
        end
      end
    end
  end
end