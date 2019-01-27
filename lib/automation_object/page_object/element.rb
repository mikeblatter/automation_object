# frozen_string_literal: true

require_relative 'base'

module AutomationObject
  module PageObject
    class Element
      include AutomationObject::PageObject::Base

      # path to element
      # @return [Symbol, nil]
      def css
        self.class.options[:css]
      end

      # path to element
      # @return [Symbol, nil]
      def xpath
        self.class.options[:xpath]
      end

      # loading hook
      # @return [AutomationObject::PageObject::Hook, nil]
      def load
        self.class.options[:load]
      end

      # Iframe element name it is under
      # @return [Symbol, String]
      def in_iframe
        self.class.options[:in_iframe]
      end

      class << self
        # Set css path to element
        # @param [String] path
        def css(path)
          options[:css] = path
        end

        # Set xpath path to element
        # @param [String, Symbol] path
        def xpath(path)
          options[:xpath] = path
        end

        # loading hook
        # @param [AutomationObject::PageObject::Hook] hook
        def load(hook)
          options[:load] = hook
        end

        # Iframe element name it is under
        # @param [Symbol, Symbol] element iframe is in
        def in_iframe(element)
          options[:in_iframe] = element
        end
      end
    end
  end
end
