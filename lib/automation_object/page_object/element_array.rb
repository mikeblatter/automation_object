# frozen_string_literal: true

module AutomationObject
  module PageObject
    class ElementArray
      class << self
        # path to element
        # @return [String, nil] css to element
        attr_accessor :css

        # path to element
        # @return [String, nil] xpath to element
        attr_accessor :xpath

        # loading hook
        # @return [AutomationObject::PageObject::Hook, nil]
        attr_accessor :load

        # Iframe it is under
        # @return [AutomationObject::PageObject::Screen, nil]
        attr_accessor :in_iframe
      end
    end
  end
end
