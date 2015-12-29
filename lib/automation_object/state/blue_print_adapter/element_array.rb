require_relative 'composite'

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementArray < Composite
        # @return [Array] Array of elements
        def load
          return self.driver.find_elements(*self.blue_prints.selector_params)
        end
      end
    end
  end
end