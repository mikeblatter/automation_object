# frozen_string_literal: true

require_relative '../driver'
require_relative 'element_geometry'

module AutomationObject
  module Driver
    module CommonSelenium
      # Helper module for Selenium based elements
      module Element
        include ElementGeometry

        # @return [Boolean] element visible
        def visible?
          @subject.displayed?
        end

        # @return [Boolean] element invisible
        def invisible?
          @subject.displayed? ? false : true
        end

        # @return [String, nil] id of element
        def id
          @subject.attribute('id')
        end

        # @return [String, nil] href of element
        def href
          @subject.attribute('href')
        end

        # Text of element
        # @return [String, nil]
        def text
          @subject.text
        end

        # @return [String, nil] content of element
        def content
          @subject.attribute('content')
        end

        # @param key [String] attribute key to get or set
        # @param value [Object] optional value to set the key as
        # @return [Object] value of attribute
        def attribute(key, value = false)
          if value
            script = "return arguments[0].#{key} = '#{value}'"
            @driver.execute_script(script, @subject)
          end

          @subject.attribute(key)
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

        # Perform a submit action on an element
        # @return [void]
        def submit
          @subject.submit
        end

        # Perform a click action on the element
        # @return [void]
        def click
          scroll_into_view if @driver.browser?
          @subject.click
        end

        # Hover over element
        def hover
          scroll_into_view
          @driver.action.move_to(@subject).perform
        end

        # Helper method to switch to this element's iframe
        def switch_to_iframe
          @driver.switch_to.frame(iframe_switch_value)
        end

        protected

        # Helper method for getting the value to switch to
        # If value doesn't exist then create one
        # @return [String] iframe value to switch to
        def iframe_switch_value
          iframe_switch_value = attribute('id')
          iframe_switch_value = attribute('name') if iframe_switch_value.length.zero?

          iframe_switch_value = attribute('name', SecureRandom.hex(16)) unless iframe_switch_value

          iframe_switch_value
        end
      end
    end
  end
end
