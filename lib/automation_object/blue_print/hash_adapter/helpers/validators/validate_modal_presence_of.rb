# frozen_string_literal: true
require_relative 'validate'

module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Validator that tests that a modal is defined when it is called elsewhere through a hook
        class ValidateModalPresenceOf < Validate
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
            target_values = target_value.is_a?(Array) ? target_value : [target_value]

            return unless target_value

            valid_modals = find_modals(composite_object)

            target_values.each do |modal|
              modal = modal.to_sym
              next if valid_modals.include?(modal)

              error_message = "Invalid Modal: #{modal}, at: #{composite_object.location}[#{@key}]."
              error_message += " Valid Modal(s): #{valid_modals}"
              error_messages.push(error_message)
            end
          end

          # Traverses up a composite tree to find :modals in a hash
          # @param composite_object [Object] composite object to traverse up
          # @return [Array<Symbol>] array of modal names
          def find_modals(composite_object)
            # Using the hash instead of the method because lower nodes will get validated
            # before composite is finished building
            if composite_object.hash[:modals].is_a?(Hash)
              return composite_object.hash[:modals].keys # Should be Hash with modal names as the keys
            elsif composite_object.parent
              return find_modals(composite_object.parent)
            end

            []
          end
        end
      end
    end
  end
end
