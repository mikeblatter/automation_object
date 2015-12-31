require_relative 'composite'
require_relative 'element_proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementArray < Composite
        # @return [Array] Selenium type elements
        def load(window_manager)
          elements = self.driver.find_elements(*self.blue_prints.selector_params)

          wrapped_elements = elements.map {|element|
            ElementProxy.new(subject: element,
                             blue_prints: self.blue_prints,
                             window_manager: window_manager)
          }

          return wrapped_elements
        end
      end
    end
  end
end