require_relative 'composite'

module AutomationObject
  module State
    module BluePrintAdapter
      class Element < Composite
        # @return [Object] Selenium type element
        def load
          return self.driver.find_element(*self.blue_prints.selector_params)
        end
      end
    end
  end
end