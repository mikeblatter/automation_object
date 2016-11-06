# frozen_string_literal: true
require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    module Composite
      # Element hash composite for managing state
      class ElementHash < Base
        include CommonElement

        # @return [Hash<String, AutomationObject::State::Composite::ElementProxy>] Selenium proxy
        def load
          elements = driver.find_elements(*blue_prints.selector_params)
          elements_hash = {}

          elements.each do |element|
            # Want to wrap element, before sending for method!
            # That will help us include custom methods, etc...
            wrapped_element = ElementProxy.new(self, element)
            hash_key = wrapped_element.send(blue_prints.define_elements_by) # Send to wrapped state proxy

            elements_hash[hash_key] = wrapped_element
          end

          elements_hash
        end
      end
    end
  end
end
