# frozen_string_literal: true

module AutomationObject
  module StepDefinitions
    # Element array module for iterating through an array
    module ElementArray
      module_function

      def iterate_and_do(screen, modal, element, key, low_range, high_range)
        element_array = AutomationObject::Framework.get.screen(screen).modal(modal).element_array(element)
        assert element_array.is_a?(Array)

        return range(element_array, low_range, high_range) if low_range && high_range

        case key
        when 'all'
          element_array.each do |sub_element|
            yield sub_element
          end
        when 'random'
          yield element_array[rand(0..(element_array.length - 1))]
        when 'first'
          yield element_array[0]
        when 'last'
          yield element_array[element_array.length - 1]
        else
          yield element_array[key.to_i]
        end
      end

      private

      def range(element_array, low_range, high_range)
        low_range.to_i..high_range.to_i.each do |i|
          assert element_array.length > i
          yield element_array[i]
        end
      end
    end
  end
end
