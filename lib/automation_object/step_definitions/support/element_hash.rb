# frozen_string_literal: true

module AutomationObject
  module StepDefinitions
    # Element hash module for iterating through an hash
    module ElementHash
      module_function

      def iterate_and_do(screen, modal, element, key, low_range, high_range)
        element_hash = AutomationObject::Framework.get.screen(screen).modal(modal).element(element)
        assert element_hash.is_a?(Hash)

        return range(element_hash, low_range, high_range) if low_range && high_range

        case key
        when 'all'
          element_hash.each_value do |sub_element|
            yield sub_element
          end
        when 'random'
          yield element_hash[element_hash.keys[rand(0..(element_hash.keys.length - 1))]]
        when 'first'
          yield element_hash[element_hash.keys[0]]
        when 'last'
          yield element_hash[element_hash.keys[element_hash.keys.length - 1]]
        else
          yield element_hash[key.to_s]
        end
      end

      private

      def range(element_hash, low_range, high_range)
        low_range.to_i..high_range.to_i.each do |i|
          assert element_hash.keys.length > i

          block.call element_hash[element_hash.keys[i]]
        end
      end
    end
  end
end
