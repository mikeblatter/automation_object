# frozen_string_literal: true
# Class for caching values between steps
module AutomationObject
  module StepDefinitions
    # Cache module for temporary storage of vars
    module Cache
      module_function

      # Singleton hash, create new if needed
      # @return [Hash] hash of values saved or new hash
      def values
        return @values if @values
        @values = {}
      end

      def get(key)
        values[key]
      end

      def set(key, value)
        values[key] = value
      end
    end
  end
end
