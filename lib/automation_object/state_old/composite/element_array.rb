require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    module Composite
      class ElementArray < AutomationObject::State::Composite::Base
        include CommonElement

        # @return [Array<AutomationObject::State::Composite::ElementProxy>] Selenium proxy
        def load
          elements = self.driver.find_elements(*self.blue_prints.selector_params)

          wrapped_elements = elements.map { |element|
            ElementProxy.new(composite: self, element: element)
          }

          return wrapped_elements
        end
      end
    end
  end
end