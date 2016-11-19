# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    # Element requirement hook loop
    class ElementRequirement < ActionLoop
      def element
        @element ||= driver.find_element(*blue_prints.element_blueprints.selector_params)
      end

      def single_run
        blue_prints.hook_order.each do |requirement_name|
          next if blue_prints.requirement(requirement_name).nil?

          requirement_value = blue_prints.requirement(requirement_name)

          case requirement_name
          when :exists?
            return false if requirement_value != driver.exists?(*blue_prints.element_blueprints.selector_params)
          else
            return false if requirement_value != element.send(requirement_name)
          end
        end

        true
      end
    end
  end
end
