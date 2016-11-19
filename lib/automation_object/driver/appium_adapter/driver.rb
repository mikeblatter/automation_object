# frozen_string_literal: true
require 'appium_lib'

require_relative '../../proxy/proxy'

require_relative '../driver'
require_relative '../common_selenium/driver'

require_relative '../element'
require_relative 'element'

module AutomationObject
  module Driver
    module AppiumAdapter
      # Driver proxy for Appium
      # Conform Appium driver interface to what's expected of the Driver Port
      class Driver < AutomationObject::Proxy::Proxy
        include AutomationObject::Driver::CommonSelenium::Driver

        DOCUMENT_COMPLETE_LOOPS = 5
        DOCUMENT_COMPLETE_SLEEP = 0.2

        # @param driver [Appium::Driver] Appium Driver
        def initialize(driver)
          @subject = driver
        end

        # Navigates current window to a given url
        # @param url [String] navigate to the following url
        # @return [void]
        def get(url)
          @subject.get(url)
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
          @subject.set_wait(timeout)
        end

        # @param selector_type [Symbol] selector type (:css, :xpath, etc...)
        # @param selector_path [String] path to element
        # @return [Boolean] exists or not
        def exists?(selector_type, selector_path)
          @subject.exists { @subject.find_element(selector_type, selector_path) }
        end

        # @param selector_type [Symbol] selector type, :css, :xpath, etc...
        # @param selector_path [String] path to element
        # @return [AutomationObject::Driver::Element] element
        def find_element(selector_type, selector_path)
          element = @subject.find_element(selector_type, selector_path)
          # Wrap element in the adapter interface
          AutomationObject::Driver::Element.new(Element.new(self, element))
        end

        # @param selector_type [Symbol] selector type, :css, :xpath, etc...
        # @param selector_path [String] path to element
        # @return [Array<AutomationObject::Driver::Element>] element
        def find_elements(selector_type, selector_path)
          elements = @subject.find_elements(selector_type, selector_path)

          elements.map do |element|
            # Wrap element in the adapter interface
            AutomationObject::Driver::Element.new(Element.new(self, element))
          end
        end

        # @return [void]
        def accept_prompt
          @subject.alert_accept
        end

        # @return [void]
        def dismiss_prompt
          @subject.alert_dismiss
        end

        # @return [Boolean] whether or not browser is being used
        def browser?
          return @browser unless @browser.nil?
          @browser = false

          # Now we need to check Appium's contexts to see if WEBVIEW is in available_contexts
          available_contexts = @subject.available_contexts
          available_contexts.each do |context|
            if context =~ /^WEBVIEW_\d+$/
              @browser = true
              break
            end
          end

          @browser
        end

        # Window Handles Override
        # @return [Array<String>] array of window handles
        def window_handles
          if @subject.device_is_android? && browser?
            window_handles = @subject.window_handles
          else
            return @subject.available_contexts unless browser?

            window_handles = []
            @subject.available_contexts.each do |context|
              window_handles.push(context) if context =~ /^WEBVIEW_\d+$/
            end
          end

          window_handles
        end

        # Get window handle override
        # @return [String] current window handle
        def window_handle
          return @subject.current_context unless browser?

          return @subject.window_handle if @subject.device_is_android?

          @subject.current_context
        end

        # Set window handle override
        # @param handle_value [String] window handle value
        # @return [void]
        def window_handle=(handle_value)
          if @subject.device_is_android?
            @subject.switch_to.window(handle_value)
          else
            @subject.set_context(handle_value)
          end
        end

        # @return [Boolean] document is complete
        def document_complete?
          return true unless browser? # Skip for non-browser Appium sessions

          # Loop through a few times to double check correctness
          DOCUMENT_COMPLETE_LOOPS.times do
            sleep(DOCUMENT_COMPLETE_SLEEP)
            return false unless @subject.execute_script('return document.readyState;') == 'complete'
          end

          true
        end

        # Close current window
        # @return [void]
        def close
          @subject.close
        end

        # @return [void]
        def quit
          @subject.driver_quit
        end
      end
    end
  end
end
