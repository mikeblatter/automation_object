# frozen_string_literal: true

require_relative 'validate'

module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Validates tests the a key exists on a composite hash
        class ValidatePresenceOf < Validate
          # @param args [Hash] arguments for the validation class
          def initialize(args)
            @key = args.fetch :key

            options = args.fetch :args, {}
            options = options.is_a?(Hash) ? options : {}
            @unless_presence_of = options.fetch :unless_presence_of, nil
          end

          # Validates the composite object and throws errors on failure
          # @param composite_object [Object] Composite object to be tested.
          # @return [nil] no return on exceptions on failure
          def validate(composite_object)
            # Get the hash value from the composite object
            return if composite_object.hash.key?(@key)

            # Do unless_presence_of check
            if @unless_presence_of
              return if composite_object.hash.key?(@unless_presence_of)
            end

            error_messages.push("Required Key Missing: #{@key}, at: #{composite_object.location}.")
          end
        end
      end
    end
  end
end
