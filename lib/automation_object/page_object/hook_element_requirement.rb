# frozen_string_literal: true

require_relative 'base'

module AutomationObject
  module PageObject
    class HookElementRequirement
      include AutomationObject::PageObject::Base

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
