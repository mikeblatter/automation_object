require_relative 'error'

module AutomationObject
  module Driver
    module NokogiriAdapter
      #Element for nokogiri
      #Conforms to Element interface for an XML source using Nokogiri
      class Element
        # @param [AutomationObject::Driver::NokogiriAdapter::Driver] driver
        # @param [Nokogiri::XML::Node] element
        def initialize(driver, element)
          @driver = driver
          @subject = element
        end

        # Set or Get attribute
        # @param key [String] key of element
        # @param value [String, nil] set value or leave blank
        # @return [String, nil]
        def attribute(key, value = nil)
          @subject[key] = value if value
          return @subject[key]
        end

        # @return [String] id of element
        def id
          @subject['id']
        end

        # @return [String] href of element
        def href
          @subject['href']
        end

        # Text of element
        # @return [String, nil]
        def text
          @subject['content']
        end

        # Type into an element
        # @return [void]
        def send_keys(string)
          if @subject['value'].is_a?(String)
            @subject['value'] = @subject[key] + string
          end

          @subject['value'] = value
        end

        # Clear the element field
        # @return [void]
        def clear
          @subject['value'] = ''
        end

        # @return [Boolean]
        def visible?
        end

        # @return [Boolean]
        def invisible?
        end

        # Get the location
        # @return [Point]
        def location
        end

        # Get the size of an element
        # @return [Dimension]
        def size
        end

        # Perform a submit action on an element
        # @return [void]
        def submit
          form_element = find_form(@subject)
          raise NoSuchElementError unless form_element

          @driver.session.new_window if form_element.new_window?
          @driver.session.send(form.request_method, form.params)
        end

        # Scroll the element into view
        # @return [void]
        def scroll_into_view
        end

        # Perform a click action on the element
        # @return [void]
        def click
          if self.href and @subject['tag'] == 'a'
            if self.attribute('target') == '_blank'
              @driver.session.new_window
            end

            @driver.session.get(self.href)
          end

          #In case it's a button inside the form
          self.submit if find_form(@subject)
        end

        private

        # @return [AutomationObject::Driver:NokogiriAdapter::Form]
        def find_form(element)
          return nil unless element

          return AutomationObject::Driver::NokogiriAdapter::Form.new(element) if element.name == 'form'
          return find_form(element.parent)
        end
      end
    end
  end
end