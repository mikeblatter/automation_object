# frozen_string_literal: true

require_relative 'element'

module AutomationObject
  module PageObject
    class ElementHash < Element
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
