require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    module Composite
      class ElementHash < AutomationObject::State::Composite::CompositeBase
        include CommonElement

        # @return [Hash<String, AutomationObject::State::Composite::ElementProxy>] Selenium proxy
        def load
          elements = self.driver.find_elements(*self.blue_prints.selector_params)
          elements_hash = {}

          elements.each { |element|
            #Want to wrap element, before sending for method!
            #That will help us include custom methods, etc...
            wrapped_element = ElementProxy.new(composite: self, element: element)
            hash_key = wrapped_element.send(self.blue_prints.define_elements_by) #Send to wrapped state proxy

            elements_hash[hash_key] = wrapped_element
          }

          return elements_hash
        end
      end
    end
  end
end