# frozen_string_literal: true
require_relative 'validate'

module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Validator that tests the composite hash for bad keys
        class ValidateAllowedKeys < Validate
          # @param args [Hash] arguments for the validation class
          def initialize(args)
            @allowed_keys = args.fetch :allowed_keys
          end

          # Validates the composite object and throws errors on failure
          # @param composite_object [Object] Composite object to be tested.
          # @return [nil] no return on exceptions on failure
          def validate(composite_object)
            # Get the hash from the composite object
            target_hash = composite_object.hash

            target_hash.each_key do |key|
              error_messages.push("Invalid Key: #{key}, at: #{composite_object.location}. Allowed keys: #{@allowed_keys}.") unless @allowed_keys.include?(key)
            end
          end
        end
      end
    end
  end
end
