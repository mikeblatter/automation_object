# frozen_string_literal: true
require_relative '_base'
require_relative '_common_element'

require_relative 'element_proxy'

module AutomationObject
  module State
    # Element hash composite for managing state
    class ElementHash < Base
      include CommonElement

      # @return [Hash<String, AutomationObject::State::ElementProxy>] Selenium proxy
      def utilize
        return self.cache if self.cache

        elements = driver.find_elements(*blue_prints.selector_params)
        self.cache = {}

        elements.each do |element|
          # Want to wrap element, before sending for method!
          # That will help us include custom methods, etc...
          wrapped_element = ElementProxy.new(self, element)
          hash_key = wrapped_element.send(blue_prints.define_elements_by) # Send to wrapped state proxy

          cache[hash_key] = wrapped_element
        end

        @active = true
        cache
      end
    end
  end
end
