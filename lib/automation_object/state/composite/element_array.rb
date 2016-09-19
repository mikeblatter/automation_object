# frozen_string_literal: true
require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    module Composite
      class ElementArray < Base
        include CommonElement

        # @return [Array<AutomationObject::State::Composite::ElementProxy>] Selenium proxy
        def load
          elements = driver.find_elements(*blue_prints.selector_params)

          wrapped_elements = elements.map do |element|
            ElementProxy.new(composite: self, element: element)
          end

          wrapped_elements
        end
      end
    end
  end
end
