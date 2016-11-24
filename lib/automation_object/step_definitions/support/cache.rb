# frozen_string_literal: true
# Class for caching values between steps
module AutomationObject
  module StepDefinitions
    # Cache module for temporary storage of vars
    module Cache
      extend self

      # Singleton hash, create new if needed
      # @return [Hash] hash of values saved or new hash
      def values
        @values ||= {}
      end

      # @return [Object]
      def get(key)
        values[key]
      end

      # @param key [Object]
      # @param value [Object]
      # @return [void]
      def set(key, value)
        values[key] = value
      end
    end
  end
end
