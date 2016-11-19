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
          # return self.cache if self.cache

          element = driver.find_element(*blue_prints.selector_params)
          self.cache = ElementProxy.new(self, element)
        end

        # Whether or not modal is active
        attr_writer :active

        # @return [Boolean] screen is active or not
        def active
          @active ||= false
        end
      end
    end
  end
end
