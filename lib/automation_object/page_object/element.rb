# frozen_string_literal: true

module AutomationObject
  module PageObject
    class Element
      # path to element
      # @return [Symbol, nil]
      def css
        self.class._css
      end

      # path to element
      # @return [Symbol, nil]
      def xpath
        self.class._xpath
      end

      # loading hook
      # @return [AutomationObject::PageObject::Hook, nil]
      def load
        self.class._load
      end

      # Iframe it is under
      # @return [Symbol, String]
      def in_iframe
        self.class._in_iframe
      end

      class << self
        attr_reader :_css, :_xpath, :_load, :_in_iframe

        # Set css path to element
        # @param [String] path
        def css(path)
          @_css = path
        end

        # Set xpath path to element
        # @param [String, Symbol] path
        def xpath(path)
          @_xpath = path
        end

        # loading hook
        # @param [AutomationObject::PageObject::Hook] hook
        def load(hook)
          @_load = hook
        end

        # Iframe it is under
        # @param [Symbol, Symbol] element iframe is in
        def in_iframe(element)
          @_in_iframe = element
        end
      end
    end
  end
end
