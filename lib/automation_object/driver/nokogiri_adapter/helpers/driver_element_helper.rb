require_relative '../error'

module AutomationObject::Driver::NokogiriAdapter
  module DriverElementHelper
    # @param selector_type [Symbol] selector type, :css, :xpath, etc...
    # @param selector_path [String] path to element
    # @return [Element] element
    def find_element(selector_type, selector_path)
      elements = self.get_elements(selector_type, selector_path)
      raise NoSuchElementError if elements.length == 0

      return AutomationObject::Driver::NokogiriAdapter::Element.new(driver: self, element: elements.first)
    end

    # @param selector_type [Symbol] selector type, :css, :xpath, etc...
    # @param selector_path [String] path to element
    # @return [Array<Element>] elements
    def find_elements(selector_type, selector_path)
      elements = self.get_elements(selector_type, selector_path)
      return elements.map { |element|
        AutomationObject::Driver::NokogiriAdapter::Element.new(driver: self, element: element)
      }
    end

    # @param selector_type [Symbol] selector type, :css, :xpath, etc...
    # @param selector_path [String] path to element
    # @return [Boolean] element exists?
    def exists?(selector_type, selector_path)
      elements = self.get_elements(selector_type, selector_path)
      return (elements.length > 0) ? true : false
    end

    protected

    def get_elements(selector_type, selector_path)
      case selector_type
        when :xpath
          elements = self.xml.xpath(selector_path)
        when :css
          elements = self.xml.css(selector_path)
        else
          raise ArgumentError, "#{selector_type} selector type not implemented. Only :css, :xpath"
      end

      return elements
    end
  end
end