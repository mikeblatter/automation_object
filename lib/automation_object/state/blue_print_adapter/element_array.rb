require_relative 'composite'
<<<<<<< HEAD
=======
require_relative 'helpers/element_helper'

require_relative 'element_proxy'
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementArray < Composite
<<<<<<< HEAD

=======
        include ElementHelper

        # @return [Array<AutomationObject::State::BluePrintAdapter::ElementProxy>] Selenium proxy
        def load
          elements = self.driver.find_elements(*self.blue_prints.selector_params)

          wrapped_elements = elements.map {|element|
            ElementProxy.new(composite: self, element: element)
          }

          return wrapped_elements
        end
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end