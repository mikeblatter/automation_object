require 'appium_lib'

require_relative '../../proxies/proxy'
require_relative '../helpers/selenium_driver_helper'

require_relative '../element'
require_relative 'element'

module AutomationObject
  module Driver
    module AppiumAdapter
      #Driver proxy for Appium
      #Conform Appium driver interface to what's expected of the Driver Port
      class Driver < AutomationObject::Proxies::Proxy
        DOC_COMPLETE_SLEEP = 1

        include AutomationObject::Driver::SeleniumDriverHelper

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

        # @param script [String] JS to run
        # @return [Object, nil]
        def execute_script(script)
          @subject.execute_script(script)
        end

        #Set timeout wait
        # @param timeout [Integer] the timeout in seconds
        # @return [void]
        def set_wait(timeout = nil)
          @subject.set_wait(timeout)
        end

        # @param selector_type [Symbol] selector type (:css, :xpath, etc...)
        # @param selector_path [String] path to element
        # @return [Boolean] exists or not
        def exists?(selector_type, selector_path)
          return @subject.exists { @subject.find_element(selector_type, selector_path) }
        end

        # @param selector_type [Symbol] selector type, :css, :xpath, etc...
        # @param selector_path [String] path to element
        # @return [AutomationObject::Driver::Element] element
        def find_element(selector_type, selector_path)
          element = @subject.find_element(selector_type, selector_path)
          #Wrap element in the adapter interface
          return AutomationObject::Driver::Element.new(Element.new(driver: self, element: element))
        end

        # @param selector_type [Symbol] selector type, :css, :xpath, etc...
        # @param selector_path [String] path to element
        # @return [Array<AutomationObject::Driver::Element>] element
        def find_elements(selector_type, selector_path)
          elements = @subject.find_elements(selector_type, selector_path)

          elements.map { |element|
            #Wrap element in the adapter interface
            AutomationObject::Driver::Element.new(Element.new(driver: self, element: element))
          }
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
        def is_browser?
          return @is_browser unless @is_browser == nil
          @is_browser = false

          #Now we need to check Appium's contexts to see if WEBVIEW is in available_contexts
          available_contexts = @subject.available_contexts
          available_contexts.each { |context|
            if context.match(/^WEBVIEW_\d+$/)
              @is_browser = true
              break
            end
          }

          return @is_browser
        end

        #Window Handles Override
        # @return [Array<String>] array of window handles
        def window_handles
          if @subject.device_is_android? and self.is_browser?
            window_handles = @subject.window_handles
          else
            return @subject.available_contexts unless self.is_browser?

            window_handles = []
            @subject.available_contexts.each { |context|
              window_handles.push(context) if context.match(/^WEBVIEW_\d+$/)
            }
          end

          return window_handles
        end

        #Get window handle override
        # @return [String] current window handle
        def window_handle
          return @subject.current_context unless self.is_browser?

          if @subject.device_is_android?
            return @subject.window_handle
          else
            return @subject.current_context
          end
        end

        #Set window handle override
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
          return true unless self.is_browser? #Skip for non-browser Appium sessions
          return @subject.execute_script('return document.readyState;') == 'complete'
        end

        # Wait till the document is complete
        # @return [void]
        def document_complete_wait
          30.times do
            sleep(DOC_COMPLETE_SLEEP)
            break if self.document_complete?
          end
        end

        # @return [void]
        def quit
          @subject.driver_quit
        end
      end
    end
  end
end