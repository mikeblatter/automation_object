require_relative '../helpers/selenium_element_helper'

module AutomationObject
  module Driver
    module SeleniumAdapter
      #Element proxy for Selenium
      #Conform Selenium element interface to what's expected of the Driver Port
      class Element < AutomationObject::Proxies::Proxy
        include AutomationObject::Driver::SeleniumElementHelper

        def initialize(args)
          @driver = args.fetch :driver
          @subject = args.fetch :element
        end

        # Set or Get attribute
        # @param key [String] key of element
        # @param value [String, nil] set value or leave blank
        # @return [String, nil]
        def attribute(key, value = nil)
          @subject.attribute(key, value)
        end

        # @return [String] id of element
        def id
          @subject.id
        end

        # @return [String] href of element
        def href
          @subject.attribute('href')
        end

        # Text of element
        # @return [String, nil]
        def text
          @subject.text
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

        # @return [Boolean]
        def visible?
          @subject.displayed?
        end

        # @return [Boolean]
        def invisible?
          !@subject.displayed?
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

        # Scroll the element into view
        # @return [void]
        def scroll_into_view
          @subject.location_once_scrolled_into_view

          element_location = self.location
          scroll_position = @driver.scroll_position

          middle_y_bounds = scroll_position[:y] + @driver.inner_window_height/2

          if middle_y_bounds > element_location.y
            #Add
            y_difference = middle_y_bounds - element_location.y
            scroll_y_position = scroll_position[:y] - y_difference
          else
            #Subtract
            y_difference = element_location.y - middle_y_bounds
            scroll_y_position = scroll_position[:y] + y_difference
          end

          #Get the element to halfway
          scroll_x_position = element_location.x.to_f

          javascript_string = "return window.scroll(#{scroll_x_position}, #{scroll_y_position});"
          @driver.execute_script(javascript_string)
        end

        # Perform a click action on the element
        # @return [void]
        def click
          self.scroll_into_view
          @subject.click
        end
      end
    end
  end
end