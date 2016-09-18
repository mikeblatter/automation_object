module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Super-class for validators, contains base functionality
        # Sub-classes must implement validate for the composite
        class Validate
          attr_accessor :error_messages

          # Remove getter to solve stupid Ruby warning
          undef :error_messages if method_defined? :error_messages
          # @return [Array<String>] array of error messages, default empty array
          def error_messages
            @error_messages ||= Array.new
          end

          # @return [Boolean] whether or not validation passed or failed
          def valid?
            return (self.error_messages.length == 0) ? true : false
          end
        end
      end
    end
  end
end
