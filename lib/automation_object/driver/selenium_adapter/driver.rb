# frozen_string_literal: true
require_relative '../../proxy/proxy'

require_relative '../driver'
require_relative '../common_selenium/driver'

require_relative '../element'
require_relative 'element'

module AutomationObject
  module Driver
    module SeleniumAdapter
      # Driver proxy for Selenium
      # Conform Selenium driver interface to what's expected of the Driver Port
      class Driver < AutomationObject::Proxy::Proxy
        include AutomationObject::Driver::CommonSelenium::Driver

        # @param driver [Selenium::WebDriver::Driver] Selenium Web Driver
        def initialize(driver)
          @subject = driver
        end

        # Navigates current window to a given url
        # @param url [String] navigate to the following url
        # @return [void]
        def get(url)
          @subject.navigate.to(url)
        end

        # Get the title of the document
        # @return [String]
        def title
          @subject.title
        end

        # Set timeout wait
        # @param timeout [Integer] the timeout in seconds
        # @return [void]
        def wait(timeout = nil)
          timeout = 0 unless timeout
          @subject.manage.timeouts.implicit_wait = timeout
        end

        # @param selector_type [Symbol] selector type (:css, :xpath, etc...)
        # @param selector_path [String] path to element
        # @return [Boolean] exists or not
        def exists?(selector_type, selector_path)
          exists = false

          begin
            suspend_timeout do
              element_objects = @subject.find_elements(selector_type, selector_path)
              exists = true unless element_objects.empty?
            end
          rescue StandardError
            return false
          end

          exists
        end

        # @param selector_type [Symbol] selector type, :css, :xpath, etc...
        # @param selector_path [String] path to element
        # @return [Object] element
        def find_element(selector_type, selector_path)
          element = @subject.find_element(selector_type, selector_path)

          # Wrap in adapter interface
          AutomationObject::Driver::Element.new(Element.new(self, element))
        end

        # @param selector_type [Symbol] selector type, :css, :xpath, etc...
        # @param selector_path [String] path to element
        # @return [Object] element
        def find_elements(selector_type, selector_path)
          elements = @subject.find_elements(selector_type, selector_path)

          elements.map do |element|
            AutomationObject::Driver::Element.new(Element.new(self, element))
          end
        end

        # Accept prompt either in browser or mobile
        def accept_prompt
          alert = @subject.switch_to.alert
          alert.accept
          @subject.switch_to.default_content
        end

        # Dismiss the prompt
        def dismiss_prompt
          alert = @subject.switch_to.alert
          alert.dismiss
          @subject.switch_to.default_content
        end

        # Check if browser, more useful for Appium but can be generic here
        # @return [Boolean] whether or not browser is being used
        def browser?
          true
        end

        # Window Handles
        # @return [Array<String>] array of window handle ids
        def window_handles
          @subject.window_handles
        end

        # Current window handle
        # @return [String] handle id
        def window_handle
          @subject.window_handle
        end

        # Set current window handle to, will switch windows
        # @param handle_value [String] window handle value
        def window_handle=(handle_value)
          @subject.switch_to.window(handle_value)
        end

        # Run script in browser to check if document in JS is complete
        # @return [Boolean] document is complete
        def document_complete?
          @subject.execute_script('return document.readyState;') == 'complete'
        end

        # Destroy the driver
        def quit
          @subject.quit
        end
      end
    end
  end
end
