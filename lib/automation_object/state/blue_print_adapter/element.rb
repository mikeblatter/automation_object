require_relative 'composite'
require_relative 'helpers/element_helper'

require_relative 'element_proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      class Element < Composite
        include ElementHelper

        # @return [AutomationObject::State::BluePrintAdapter::ElementProxy] Selenium proxy
        def load
          element = self.driver.find_element(*self.blue_prints.selector_params)
          ElementProxy.new(composite: self, element: element)
        end
      end
    end
  end
end