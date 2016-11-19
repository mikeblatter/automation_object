# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    # Wait for elements hook loop
    class WaitForElements < ActionLoop
      def single_run
        blue_prints.each do |hook_element_requirement|
          hook_element_requirement = ElementRequirement.new(driver, hook_element_requirement, 1)
          return false unless hook_element_requirement.run
        end

        true
      end
    end
  end
end
