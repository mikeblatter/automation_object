#Class for caching values between steps
module AutomationObject
  module StepDefinitions
    module Cache
      extend self

      #Singleton hash, create new if needed
      # @return [Hash] hash of values saved or new hash
      def values
        return @values if @values
        @values = {}
      end

      def get(key)
        return self.values[key]
      end

      def set(key, value)
        self.values[key] = value
      end
    end
  end
end