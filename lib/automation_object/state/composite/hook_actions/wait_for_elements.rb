require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      class WaitForElements < ActionLoop
        def single_run
          self.blue_prints.each { |hook_element_requirement|
            hook_element_requirement = ElementRequirement.new(blue_prints: hook_element_requirement,
                                                              composite: self,
                                                              loops: 1)
            return false unless hook_element_requirement.run
          }

          return true
        end
      end
    end
  end
end
