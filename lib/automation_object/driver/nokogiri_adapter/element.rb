# frozen_string_literal: true

require_relative '../driver'
require_relative 'error'

module AutomationObject
  module Driver
    module NokogiriAdapter
      # Element for nokogiri
      # Conforms to Element interface for an XML source using Nokogiri
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
          @subject[key]
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
          @subject.content
        end

        # Content of element
        # @return [String, nil]
        def content
          @subject.content
        end

        # Type into an element
        # @return [void]
        def send_keys(string)
          @subject['value'] = @subject[key] + string if @subject['value'].is_a?(String)

          @subject['value'] = value
        end

        # Clear the element field
        # @return [void]
        def clear
          @subject['value'] = ''
        end

        # @return [Boolean]
        def visible?; end

        # @return [Boolean]
        def invisible?; end

        # Get the location
        # @return [Point]
        def location; end

        # Get the size of an element
        # @return [Dimension]
        def size; end

        # Perform a submit action on an element
        # @return [void]
        def submit
          form_element = find_form(@subject)
          raise NoSuchElementError unless form_element

          @driver.session.request(form.request_method, form.url, form.params, form_element.new_window?)
        end

        # Scroll the element into view
        # @return [void]
        def scroll_into_view; end

        # Perform a click action on the element
        # @return [void]
        def click
          @driver.session.request(:get, href, {}, attribute('target') == '_blank') if href && @subject['tag'] == 'a'

          # In case it's a button inside the form
          submit if find_form(@subject)
        end

        # @return [Numeric] x position of element
        def x
          0
        end

        # @return [Numeric] y position of element
        def y
          0
        end

        # @return [Numeric] width of element
        def width
          0
        end

        # @return [Numeric] height of element
        def height
          0
        end

        # @return [Point] :x, :y coordinates
        def element_center
          Point.new(x: 0, y: 0)
        end

        # @return [BoxCoordinates] :x1, :x2, :y1, :y2 coordinates of a box
        def box_coordinates
          BoxCoordinates.new(x1: 0, y1: 0, x2: 0, y2: 0)
        end

        # @param _second_element_object [Object] element to compare to
        # @param _collision_tolerance [Numeric, FalseClass] pixel tolerance of collisions
        # @return [Boolean] element collides with other
        def collides_with_element?(_second_element_object, _collision_tolerance = false)
          false
        end

        # Hover over element
        # @return [void]
        def hover; end

        # Helper method to switch to this element's iframe
        # @return [void]
        def switch_to_iframe
          # TODO: finish
        end

        private

        # @return [AutomationObject::Driver:NokogiriAdapter::Form]
        def find_form(element)
          return nil unless element

          return AutomationObject::Driver::NokogiriAdapter::Form.new(element) if element.name == 'form'

          find_form(element.parent)
        end
      end
    end
  end
end
