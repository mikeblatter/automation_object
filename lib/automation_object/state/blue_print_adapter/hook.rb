require_relative 'hook_element_requirement'

module AutomationObject
  module State
    module BluePrintAdapter
      class Hook < Composite
        # @return [Boolean, nil] return nil if no live? check, otherwise boolean
        def live?
          return nil unless self.blue_prints.live?.length > 0

          self.blue_prints.live?.each { |element_requirement_blueprints|
            hook_element_requirement = HookElementRequirement.new(blue_prints: element_requirement_blueprints)
            hook_element_requirement.session = self.session
            hook_element_requirement.loops = 1
            hook_element_requirement.element_blueprints = self.blue_prints.parent.elements[element_requirement_blueprints.element_name]

            return false unless hook_element_requirement.run
          }

          return true
        end
      end
    end
  end
end