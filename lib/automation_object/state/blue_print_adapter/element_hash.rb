require_relative 'composite'
require_relative 'element_proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementHash < Composite
        # @return [Hash] Selenium type elements
        def load(window_manager)
          elements = self.driver.find_elements(*self.blue_prints.selector_params)
          elements_hash = {}

          elements.each { |element|
            #Want to wrap element, before sending for method!
            #That will help us include custom methods, etc...
            wrapped_element = ElementProxy.new(subject: element,
                                               blue_prints: self.blue_prints,
                                               window_manager: window_manager)
            hash_key = wrapped_element.send(self.blue_prints.define_elements_by) #Send to wrapped state proxy

            elements_hash[hash_key] = wrapped_element
          }

          return elements_hash
        end
      end
    end
  end
end