require_relative '../helpers/selenium_element_helper'

module AutomationObject
  module Driver
    module AppiumAdapter
      #Element proxy for Appium
      #Conform Appium element interface to what's expected of the Driver Port
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

          #Only scroll better if this is a browser and not an app
          return unless @driver.is_browser?

          element_center = self.element_center
          window_height = self.inner_window_height
          scroll_position = @driver.scroll_position

          if element_center[:y] < (window_height/2)
            ideal_y_position = (scroll_position[:y] + element_center[:y] - (window_height.to_f / 2.0)).abs
          else
            ideal_y_position = (scroll_position[:y] - element_center[:y] + (window_height.to_f / 2.0)).abs
          end

          @driver.execute_script("window.scroll(#{element_center[:x]},#{ideal_y_position});")
          #Just in case in close to the top or bottom bounds of the window
          element_location = @subject.location_once_scrolled_into_view

          if element_location[:y] < 0
            scroll_position = @driver.scroll_position
            scroll_y_position = scroll_position[:y] + element_location[:y]
            @driver.execute_script("window.scroll(#{element_location[:x]},#{scroll_y_position});")
          end
        end

        # Perform a click action on the element
        # @return [void]
        def click
          self.scroll_into_view if @driver.is_browser?
          @subject.click
        end
      end
    end
  end
end