# frozen_string_literal: true

require_relative 'validate'

module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Validator that tests that a element is defined when it is called elsewhere through a hook
        class ValidateElementPresenceOf < Validate
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
            valid_elements = find_elements(composite_object)

            populate_errors(target_values, valid_elements, composite_object)
          end

          private

          # Traverses up a composite tree to find :elements in a hash
          # @param composite_object [Object] composite object to traverse up
          # @return [Array<Symbol>] array of element names
          def find_elements(composite_object)
            # Using the hash instead of the method because lower nodes will get validated
            # before composite is finished building
            return composite_object.hash[:elements].keys if composite_object.hash[:elements].is_a?(Hash)

            # Should be Hash with element names as the keys
            return find_elements(composite_object.parent) if composite_object.parent

            []
          end

          def populate_errors(target_values, valid_elements, composite_object)
            target_values.each do |element|
              element = element.to_sym
              next if valid_elements.include?(element)

              error_message = "Invalid Element: #{element}, at: #{composite_object.location}[#{@key}]."
              error_message += " Valid Elements(s): #{valid_elements}"
              error_messages.push(error_message)
            end
          end
        end
      end
    end
  end
end
