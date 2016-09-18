require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      class ElementRequirement < ActionLoop
        def element
          @element ||= self.driver.find_element(*self.blue_prints.element_blueprints.selector_params)
        end

        def single_run
          self.blue_prints.hook_order.each { |requirement_name|
            next if self.blue_prints.requirement(requirement_name) == nil

            requirement_value = self.blue_prints.requirement(requirement_name)

            case requirement_name
              when :exists?
                if requirement_value != self.driver.exists?(*self.blue_prints.element_blueprints.selector_params)
                  return false
                end
              else
                if requirement_value != self.element.send(requirement_name)
                  return false
                end
            end
          }

          return true
        end
      end
    end
  end
end
