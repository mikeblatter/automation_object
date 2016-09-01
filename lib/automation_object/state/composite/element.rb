require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    module Composite
      class Element < Base
        include CommonElement

        # @return [AutomationObject::State::Composite::ElementProxy] Selenium proxy
        def load
          element = self.driver.find_element(*self.blue_prints.selector_params)
          ElementProxy.new(composite: self, element: element)
        end
      end
    end
  end
end