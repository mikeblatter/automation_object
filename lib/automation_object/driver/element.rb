require_relative 'base'

module AutomationObject
  module Driver
    class Element < Base
      # Set or Get attribute
      # @param key [String] key of element
      # @param value [String, nil] set value or leave blank
      # @return [String, nil]
      def attribute(key, value = nil)
        self.adapter.attribute(key, value)
      end

      # @return [String] id of element
      def id
        self.adapter.id
      end

      # @return [String] href of element
      def href
        self.adapter.href
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

      # @return [Numeric] x position of element
      def x
        self.adapter.x
      end

      # @return [Numeric] y position of element
      def y
        self.adapter.y
      end

      # @return [Numeric] width of element
      def width
        self.adapter.width
      end

      # @return [Numeric] height of element
      def height
        self.adapter.height
      end

      # @return [String, nil] content attribute
      def content
        self.adapter.content
      end

      # @return [Point] :x, :y coordinates
      def element_center
        self.adapter.element_center
      end

      # @return [BoxCoordinates] :x1, :x2, :y1, :y2 coordinates of a box
      def box_coordinates
        self.adapter.box_coordinates
      end

      # @param second_element_object [Object] element to compare to
      # @param collision_tolerance [Numeric, FalseClass] pixel tolerance of collisions
      # @return [Boolean] element collides with other
      def collides_with_element?(second_element_object, collision_tolerance = false)
        self.adapter.collides_with_element?(second_element_object, collision_tolerance)
      end

      # Hover over element
      # @return [void]
      def hover
        self.adapter.hover
      end

      # Helper method to switch to this element's iframe
      # @return [void]
      def switch_to_iframe
        self.adapter.switch_to_iframe
      end
    end
  end
end
