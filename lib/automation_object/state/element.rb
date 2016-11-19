# frozen_string_literal: true
require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    # Element composite for managing state
    class Element < Base
      include CommonElement

      # @return [AutomationObject::State::ElementProxy] Selenium proxy
      def utilize
        # return self.cache if self.cache

        element = driver.find_element(*blue_prints.selector_params)
        @active = true
        self.cache = ElementProxy.new(self, element)
      end
    end
  end
end
