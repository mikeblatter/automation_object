require_relative 'validate'

module AutomationObject
  module BluePrint
    module HashAdapter
      module Validators
        # Validator that tests that a view is defined when it is called elsewhere through a hook
        class ValidateViewPresenceOf < Validate
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

            valid_views = find_views(composite_object)

            target_values.each do |view|
              view = view.to_sym
              next if valid_views.include?(view)

              error_message = "Invalid View: #{view}, at: #{composite_object.location}[#{@key}]."
              error_message << " Valid Views(s): #{valid_views}"
              error_messages.push(error_message)
            end
          end

          # Need to traverse up the composite tree and find views
          def find_views(composite_object)
            # Using the hash instead of the method because lower nodes will get validated
            # before composite is finished building
            if composite_object.hash[:views].is_a?(Hash)
              return composite_object.hash[:views].keys # Should be Hash with view names as the keys
            elsif composite_object.parent
              return find_views(composite_object.parent)
            end

            []
          end
        end
      end
    end
  end
end
