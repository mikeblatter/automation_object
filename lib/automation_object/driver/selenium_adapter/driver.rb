require_relative '../../proxies/proxy'
require_relative '../helpers/selenium_driver_helper'
require_relative 'element'

module AutomationObject::Driver::SeleniumAdapter
  #Driver proxy for Selenium
  #Conform Selenium driver interface to what's expected of the Driver Port
  class Driver < AutomationObject::Proxies::Proxy
    DOC_COMPLETE_SLEEP = 1

    include AutomationObject::Driver::SeleniumDriverHelper

    # @param driver [Selenium::WebDriver::Driver] Selenium Web Driver
    def initialize(driver)
      @subject = driver
    end

    # @param selector_type [Symbol] selector type (:css, :xpath, etc...)
    # @param selector_path [String] path to element
    # @return [Boolean] exists or not
    def exists?(selector_type, selector_path)
      exists = false

      begin
        @subject.manage.timeouts.implicit_wait = 0
        element_objects = @subject.find_elements(selector_type, selector_path)
        @subject.manage.timeouts.implicit_wait = 30
        if element_objects.length > 0
          exists = true
        end
      rescue Exception => e
      end

      return exists
    end

    # @param selector_type [Symbol] selector type, :css, :xpath, etc...
    # @param selector_path [String] path to element
    # @return [Object] element
    def find_element(selector_type, selector_path)
      element = @subject.find_element(selector_type, selector_path)
      return Element.new(driver: self, element: element)
    end

    # @param selector_type [Symbol] selector type, :css, :xpath, etc...
    # @param selector_path [String] path to element
    # @return [Object] element
    def find_elements(selector_type, selector_path)
      elements = @subject.find_elements(selector_type, selector_path)
      return elements.map { |element|
        Element.new(driver: self, element: element)
      }
    end

    # @param path [String] path to create image to
    def screenshot(path)
      @subject.save_screenshot(File.expand_path(path))
    end

    def accept_prompt
      alert = @subject.switch_to.alert
      alert.accept
      @subject.switch_to.default_content
    end

    def dismiss_prompt
      alert = @subject.switch_to.alert
      alert.dismiss
      @subject.switch_to.default_content
    end

    def get(url)
      @subject.get(url)

      30.times do
        sleep(DOC_COMPLETE_SLEEP)
        break if self.document_complete?
      end
    end

    # @return [Boolean] document is complete
    def document_complete?
      return @subject.execute_script('return document.readyState;') == 'complete'
    end

    #Window handle set override
    # @param handle_value [String] window handle value
    def window_handle=(handle_value)
      @subject.switch_to.window(handle_value)
    end

    #Close every window except the current window
    def close_other_windows
      window_handles = @subject.window_handles
      return if window_handles.length <= 1 #No need if only one window

      current_window_handle = @subject.window_handle
      window_handles.each { |other_window_handle|
        next if other_window_handle == current_window_handle

        self.window_handle = other_window_handle
        @subject.close
      }

      self.window_handle = current_window_handle
    end
  end
end