# frozen_string_literal: true
require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    module Composite
      # Element composite for managing state
      class Element < Base
        include CommonElement

        # @return [AutomationObject::State::Composite::ElementProxy] Selenium proxy
        def load
          element = driver.find_element(*blue_prints.selector_params)
          puts element
          raise 'test'
          ElementProxy.new(self, element)
        end
      end
    end
  end
end
