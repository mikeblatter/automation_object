# frozen_string_literal: true
require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    module Composite
      # Element array composite for managing state
      class ElementArray < Base
        include CommonElement

        # @return [Array<AutomationObject::State::Composite::ElementProxy>] Selenium proxy
        def load
          return self.cache if self.cache

          elements = driver.find_elements(*blue_prints.selector_params)

          self.cache = elements.map do |element|
            ElementProxy.new(self, element)
          end
        end
      end
    end
  end
end
