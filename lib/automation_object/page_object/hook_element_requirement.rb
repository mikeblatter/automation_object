# frozen_string_literal: true

module AutomationObject
  module PageObject
    class HookElementRequirement
      # Key to define elements by
      # @return [Symbol, nil]
      def key
        self.class._key
      end

      class << self
        attr_reader :_key

        # method to set keys by
        # @param [Symbol, String]
        def key(method)
          @_key = method
        end
      end
    end
  end
end
