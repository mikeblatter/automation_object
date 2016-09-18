require_relative '../driver'

module AutomationObject
  module Driver
    module CommonSelenium
      # Helper module for Selenium based elements
      module Element
        # @return [Numeric] x position of element
        def x
          @subject.location.x
        end

        # @return [Numeric] y position of element
        def y
          @subject.location.y
        end

        # @return [Numeric] width of element
        def width
          @subject.size.width
        end

        # @return [Numeric] height of element
        def height
          @subject.size.height
        end

        # @return [Boolean] element visible
        def visible?
          @subject.displayed?
        end

        # @return [Boolean] element invisible
        def invisible?
          @subject.displayed? ? false : true
        end

        # @return [String, nil] id of element
        def id
          @subject.attribute('id')
        end

        # @return [String, nil] href of element
        def href
          @subject.attribute('href')
        end

        # Text of element
        # @return [String, nil]
        def text
          @subject.text
        end

        # @return [String, nil] content of element
        def content
          @subject.attribute('content')
        end

        # @param key [String] attribute key to get or set
        # @param value [Object] optional value to set the key as
        # @return [Object] value of attribute
        def attribute(key, value = false)
          if value
            script = "return arguments[0].#{key} = '#{value}'"
            @driver.execute_script(script, @subject)
          end

          @subject.attribute(key)
        end

        # Type into an element
        # @return [void]
        def send_keys(string)
          @subject.send_keys(string)
        end

        # Clear the element field
        # @return [void]
        def clear
          @subject.clear
        end

        # Get the location
        # @return [Point]
        def location
          @subject.location
        end

        # Get the size of an element
        # @return [Dimension]
        def size
          @subject.size
        end

        # Perform a submit action on an element
        # @return [void]
        def submit
          @subject.submit
        end

        # Perform a click action on the element
        # @return [void]
        def click
          scroll_into_view if @driver.is_browser?
          @subject.click
        end

        # @return [Hash] :x, :y coordinates
        def element_center
          element_location = @subject.location
          element_size = @subject.size

          center = Point.new
          center.x = (element_location.x.to_f + element_size.width.to_f / 2).to_f
          center.y = (element_location.y.to_f + element_size.height.to_f / 2).to_f

          center
        end

        # @return [BoxCoordinates] :x1, :x2, :y1, :y2 coordinates of a box
        def box_coordinates
          element_location = @subject.location
          element_size = @subject.size

          box_coordinates = BoxCoordinates.new
          box_coordinates.x1 = element_location.x.to_f
          box_coordinates.y1 = element_location.y.to_f
          box_coordinates.x2 = element_location.x.to_f + element_size.width.to_f
          box_coordinates.y2 = element_location.y.to_f + element_size.height.to_f

          box_coordinates
        end

        # @param second_element_object [Object] element to compare to
        # @param collision_tolerance [Numeric] pixel tolerance of collisions
        # @return [Boolean] element collides with other
        def collides_with_element?(second_element_object, collision_tolerance = false)
          box_one = box_coordinates
          box_two = second_element_object.box_coordinates

          collision_tolerance = 0 unless collision_tolerance.is_a?(Numeric)

          if box_one.x2 > box_two.x1 && box_one.x1 < box_two.x2 && box_one.y2 > box_two.y1 && box_one.y1 < box_two.y2
            if box_one.x2 > (box_two.x1 + collision_tolerance) && (box_one.x1 + collision_tolerance) < box_two.x2 &&
               box_one.y2 > (box_two.y1 + collision_tolerance) && (box_one.y1 + collision_tolerance) < box_two.y2
              return true
            else
              return false
            end
          else
            return false
          end
        end

        # Hover over element
        def hover
          scroll_into_view
          @driver.action.move_to(@subject).perform
        end

        # Helper method to switch to this element's iframe
        def switch_to_iframe
          @driver.switch_to.frame(iframe_switch_value)
        end

        protected

        # Helper method for getting the value to switch to
        # If value doesn't exist then create one
        # @return [String] iframe value to switch to
        def iframe_switch_value
          iframe_switch_value = attribute('id')
          if iframe_switch_value.length.zero?
            iframe_switch_value = attribute('name')
          end

          unless iframe_switch_value
            iframe_switch_value = attribute('name', SecureRandom.hex(16))
          end

          iframe_switch_value
        end
      end
    end
  end
end
