require_relative 'base'
require_relative 'driver'

module AutomationObject
  module Driver
    class Element < Base
      # Set or Get attribute
      # @return [String, nil]
      def attribute(name = nil)
        self.adapter.attribute(name)
      end

      # Text of element
      # @return [String, nil]
      def text
        self.adapter.text
      end

      # Type into an element
      # @return [void]
      def send_keys(string)
        self.adapter.send_keys(string)
      end

      # Clear the element field
      # @return [void]
      def clear
        self.adapter.clear
      end

      # @return [Boolean]
      def visible?
        self.adapter.visible?
      end

      # @return [Boolean]
      def invisible?
        self.adapter.invisible?
      end

      # Get the location
      # @return [Point]
      def location
        self.adapter.location
      end

      # Get the size of an element
      # @return [Dimension]
      def size
        self.adapter.size
      end

      # Perform a submit action on an element
      # @return [void]
      def submit
        self.adapter.submit
      end

      # Scroll the element into view
      # @return [void]
      def scroll_into_view
        self.adapter.scroll_into_view
      end

      # Perform a click action on the element
      # @return [void]
      def click
        self.adapter.click
      end
    end
  end
end