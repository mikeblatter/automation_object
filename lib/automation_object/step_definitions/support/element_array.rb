module AutomationObject
  module StepDefinitions
    # Element array module for iterating through an array
    module ElementArray
      module_function

      def iterate_and_do(screen, element, key, low_range, high_range, &block)
        element_array = AutomationObject::Framework.get.send(screen).send(element)
        assert element_array.is_a?(Array)

        case
          when low_range and high_range
            for i in low_range.to_i..high_range.to_i
              assert element_array.length > i

              block.call element_array[i]
            end
          when key == 'all'
            element_array.each { |element|
              block.call element
            }
          when key == 'random'
            block.call element_array[rand(0..(element_array.length - 1))]
          when key == 'first'
            block.call element_array[0]
          when key == 'last'
            block.call element_array[element_array.length - 1]
          else
            block.call element_array[key.to_i]
        end
      end
    end
  end
end
