require_relative 'composite'
require_relative 'element_proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementArray < Composite
        # @return [Array<AutomationObject::State::BluePrintAdapter::ElementProxy>] Selenium proxy
        def load
          elements = self.driver.find_elements(*self.blue_prints.selector_params)

          wrapped_elements = elements.map {|element|
            ElementProxy.new(composite: self, element: element)
          }

          return wrapped_elements
        end
      end
    end
  end
end