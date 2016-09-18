require_relative 'validate'

module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Validator that tests that a screen is defined when it is called elsewhere through a hook
        class ValidateScreenPresenceOf < Validate
          # @param args [Hash] arguments for the validation class
          def initialize(args)
            @key = args.fetch :key
          end

          # Validates the composite object and throws errors on failure
          # @param composite_object [Object] Composite object to be tested.
          # @return [nil] no return on exceptions on failure
          def validate(composite_object)
            # Get the hash value from the composite object
            target_value = composite_object.hash[@key]

            return unless target_value

            target_values = target_value.is_a?(Array) ? target_value : [target_value]

            valid_screens = find_screens(composite_object)

            target_values.each do |screen|
              screen = screen.to_sym
              next if valid_screens.include?(screen)

              error_message = "Invalid Screen: #{screen}, at: #{composite_object.location}[#{@key}]."
              error_message << " Valid Screen(s): #{valid_screens}"
              error_messages.push(error_message)
            end
          end

          # Traverses up a composite tree to find :screens in a hash
          # @param composite_object [Object] composite object to traverse up
          # @return [Array<Symbol>] array of screen names
          def find_screens(composite_object)
            # Using the hash instead of the method because lower nodes will get validated
            # before composite is finished building
            if composite_object.hash[:screens].is_a?(Hash)
              return composite_object.hash[:screens].keys # Should be Hash with screen names as the keys
            elsif composite_object.parent
              return find_screens(composite_object.parent)
            end

            []
          end
        end
      end
    end
  end
end
