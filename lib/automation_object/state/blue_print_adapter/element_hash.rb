require_relative 'composite'
<<<<<<< HEAD
=======
require_relative 'helpers/element_helper'

require_relative 'element_proxy'
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementHash < Composite
<<<<<<< HEAD

=======
        include ElementHelper

        # @return [Hash<String, AutomationObject::State::BluePrintAdapter::ElementProxy>] Selenium proxy
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
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end