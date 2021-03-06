# frozen_string_literal: true

# Require all the validators
require_relative 'validators/validate_instance_of'
require_relative 'validators/validate_allowed_keys'
require_relative 'validators/validate_screen_presence_of'
require_relative 'validators/validate_modal_presence_of'
require_relative 'validators/validate_view_presence_of'
require_relative 'validators/validate_element_presence_of'
require_relative 'validators/validate_presence_of'

require_relative '../../../helpers/string'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Validation helper for the composite structure, will allow Rails style validations on the composite
      module ValidationHelper
        attr_accessor :errors

        # Remove getter to solve stupid Ruby warning
        undef :errors if method_defined? :errors
        # Give errors a default empty Array
        # @return [Array<String>] errors messages
        def errors
          @errors ||= []
        end

        # Give errors a default empty Array
        # @params [Array<String>] error messages
        # @return [Array<String>] error messages
        def add_errors(errors)
          self.errors += errors
        end

        # @return [Boolean] composite valid?
        def valid?
          return true if self.class.skip_validations

          # ap self.class
          # ap self.class.name
          self.class.validations.collect do |validation|
            # ap validation.class.name
          end

          self.class.validations.collect do |validation|
            validation.validate(self)
            add_errors(validation.error_messages) unless validation.valid?
          end

          self.errors.empty?
        end

        def self.included(base)
          base.extend(ClassMethods)
        end

        # Class level methods
        module ClassMethods
          def skip_validations=(boolean)
            @skip_validations = boolean
          end

          def skip_validations
            @skip_validations ||= false
          end

          # @param key [Symbol] hash key to test
          # @param args [Hash] arguments for validation
          # @return [nil]
          def validates(key, args = {})
            args.each do |validator_name, validation_args|
              validator_name = 'Validate' + validator_name.to_s.pascalize
              validator = Validators.const_get(validator_name)

              validations.push(validator.new(key: key, args: validation_args))
            end
          end

          # @param args [Hash] arguments for validation
          # @return [nil]
          def validates_keys(args = {})
            validations.push(Validators::ValidateAllowedKeys.new(args))
          end

          # @return [Array] list of Validators, default to empty list
          def validations
            @validations = [] unless defined? @validations
            @validations
          end
        end
      end
    end
  end
end
