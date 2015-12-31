require_relative 'composite'
require_relative 'element_proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      class Element < Composite
        # @return [Object] Selenium type element
        def load(window_manager)
          element = self.driver.find_element(*self.blue_prints.selector_params)
          return ElementProxy.new(subject: element, blue_prints: self.blue_prints, window_manager: window_manager)
        end
      end
    end
  end
end