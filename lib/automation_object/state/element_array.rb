# frozen_string_literal: true

require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    # Element array composite for managing state
    class ElementArray < Base
      include CommonElement

      # @return [Array<AutomationObject::State::ElementProxy>] Selenium proxy
      def utilize
        return cache if cache

        elements = driver.find_elements(*blue_prints.selector_params)

        @active = true
        self.cache = elements.map do |element|
          ElementProxy.new(self, element)
        end
      end
    end
  end
end
