require_relative '../helpers/selenium_element_helper'

module AutomationObject::Driver::AppiumAdapter
  #Element proxy for Appium
  #Conform Appium element interface to what's expected of the Driver Port
  class Element < AutomationObject::Proxies::Proxy
    include AutomationObject::Driver::SeleniumElementHelper

    def initialize(args)
      @driver = args.fetch :driver
      @subject = args.fetch :element
    end

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
      element_location = self.location_once_scrolled_into_view

      if element_location[:y] < 0
        scroll_position = @driver.scroll_position
        scroll_y_position = scroll_position[:y] + element_location[:y]
        @driver.execute_script("window.scroll(#{element_location[:x]},#{scroll_y_position});")
      end
    end
  end
end