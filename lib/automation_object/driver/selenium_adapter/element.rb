# frozen_string_literal: true

require_relative '../common_selenium/element'

module AutomationObject
  module Driver
    module SeleniumAdapter
      # Element proxy for Selenium
      # Conform Selenium element interface to what's expected of the Driver Port
      class Element < AutomationObject::Proxy::Proxy
        include AutomationObject::Driver::CommonSelenium::Element

        def initialize(driver, element)
          @driver = driver
          @subject = element
        end

        # Scroll the element into view
        # @return [void]
        def scroll_into_view
          @subject.location_once_scrolled_into_view

          element_location = location
          scroll_position = @driver.scroll_position

          middle_y_bounds = scroll_position[:y] + @driver.inner_window_height / 2

          if middle_y_bounds > element_location.y
            # Add
            y_difference = middle_y_bounds - element_location.y
            scroll_y_position = scroll_position[:y] - y_difference
          else
            # Subtract
            y_difference = element_location.y - middle_y_bounds
            scroll_y_position = scroll_position[:y] + y_difference
          end

          # Get the element to halfway
          scroll_x_position = element_location.x.to_f

          javascript_string = "return window.scroll(#{scroll_x_position}, #{scroll_y_position});"
          @driver.execute_script(javascript_string)
        end
      end
    end
  end
end
