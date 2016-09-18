require_relative 'validate'

module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Validator that tests that a element is defined when it is called elsewhere through a hook
        class ValidateInstanceOf < Validate
          # @param args [Hash] arguments for the validation class
          def initialize(args)
            @key = args.fetch :key
            # Convert to array of instances for consistency
            @should_be_instances_of = (args.fetch(:args).is_a?(Array)) ? args.fetch(:args) : [args.fetch(:args)]
          end

          # Validates the composite object and throws errors on failure
          # @param composite_object [Object] Composite object to be tested.
          # @return [nil] no return on exceptions on failure
          def validate(composite_object)
            # Get the hash value from the composite object
            target_value = composite_object.hash[@key]

            # Skip empty or non-existent
            return unless target_value

            @should_be_instances_of.each { |should_be_instance_of|
              return if target_value.is_a?(should_be_instance_of)
            }

            error_message = "Invalid Type: #{target_value.class}, at: #{composite_object.location}[#{@key}]."
            error_message << " Allowed Type(s): #{@should_be_instances_of}"

            self.error_messages.push(error_message)
          end
        end
      end
    end
  end
end
