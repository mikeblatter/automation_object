module AutomationObject
  module StepDefinitions
    module ElementHash
      extend self

      def iterate_and_do(screen, element, key, low_range, high_range, &block)
        element_hash = AutomationObject::Framework.get.send(screen).send(element)
        assert element_hash.is_a?(Hash)

        case
          when low_range and high_range
            for i in low_range.to_i..high_range.to_i
              assert element_hash.keys.length > i

              block.call element_hash[element_hash.keys[i]]
            end
          when key == 'all'
            element_hash.each_value { |element|
              block.call element
            }
          when key == 'random'
            block.call element_hash[element_hash.keys[rand(0..(element_hash.keys.length - 1))]]
          when key == 'first'
            block.call element_hash[element_hash.keys[0]]
          when key == 'last'
            block.call element_hash[element_hash.keys[element_hash.keys.length - 1]]
          else
            block.call element_hash[key.to_s]
        end
      end
    end
  end
end
