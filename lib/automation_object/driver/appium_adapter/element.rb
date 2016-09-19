# frozen_string_literal: true
require_relative '../common_selenium/element'

module AutomationObject
  module Driver
    module AppiumAdapter
      # Element proxy for Appium
      # Conform Appium element interface to what's expected of the Driver Port
      class Element < AutomationObject::Proxy::Proxy
        include AutomationObject::Driver::CommonSelenium::Element

        def initialize(args)
          @driver = args.fetch :driver
          @subject = args.fetch :element
        end

        # Scroll the element into view
        # @return [void]
        def scroll_into_view
          @subject.location_once_scrolled_into_view

          # Only scroll better if this is a browser and not an app
          return unless @driver.is_browser?

          element_center = self.element_center
          window_height = inner_window_height
          scroll_position = @driver.scroll_position

          ideal_y_position = if element_center[:y] < (window_height / 2)
                               (scroll_position[:y] + element_center[:y] - (window_height.to_f / 2.0)).abs
                             else
                               (scroll_position[:y] - element_center[:y] + (window_height.to_f / 2.0)).abs
                             end

          @driver.execute_script("window.scroll(#{element_center[:x]},#{ideal_y_position});")
          # Just in case in close to the top or bottom bounds of the window
          element_location = @subject.location_once_scrolled_into_view

          if (element_location[:y]).negative?
            scroll_position = @driver.scroll_position
            scroll_y_position = scroll_position[:y] + element_location[:y]
            @driver.execute_script("window.scroll(#{element_location[:x]},#{scroll_y_position});")
          end
        end
      end
    end
  end
end
