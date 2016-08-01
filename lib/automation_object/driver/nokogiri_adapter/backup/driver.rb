require 'nokogiri'
require 'rest_client'

require_relative 'session'
require_relative 'element'
require_relative 'helpers/driver_element_helper'

module AutomationObject::Driver::NokogiriAdapter
  #Driver proxy for Nokogiri(XML)
  #Create driver interface that conforms to Driver port
  #Works differently than Appium/Selenium, not a proxy, but creates the functionality of the driver
  class Driver
    include DriverElementHelper

    attr_accessor :current_url

    def initialize(*args)
      @session = Session.new
    end

    def navigate
      self
    end

    def to(url)
      @session.get(url)
    end

    def back
      @session.back
    end

    def quit
      @session.quit
    end

    def close
      @session.close
    end

    def current_url
      @session.current_url
    end

    def window_handles
      @session.window_handles
    end

    def window_handle
      @session.window_handle
    end

    def window_handle=(handle_value)
      @session.window_handle = handle_value
    end

    def new_window
      @session.new_window
    end

    def xml
      @session.xml
    end

    def title
      title = ''
      title_element = self.find_element(:xpath, '//title')
      if title_element
        title = title_element.text
      end

      return title
    end

    def get(url, params = {})
      @session.get(url, params)
    end

    def post(url, params = {})
      @session.post(url, params)
    end
  end
end