<<<<<<< HEAD
require_relative 'hook_element_requirement'
=======
require_relative 'hook_action'
require_relative 'hook_actions/element_requirement'
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

module AutomationObject
  module State
    module BluePrintAdapter
      class Hook < Composite
        # @return [Boolean, nil] return nil if no live? check, otherwise boolean
        def live?
<<<<<<< HEAD
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
=======
          self.before

          return nil if self.blue_prints.live?.empty?

          self.blue_prints.live?.each { |element_requirement_blueprints|
            hook_element_requirement = ElementRequirement.new(blue_prints: element_requirement_blueprints,
                                                              composite: self,
                                                              loops: 1)
            return false unless hook_element_requirement.run
          }

          self.after

          return true
        end

        #Runs the before hook
        # @return [Boolean, nil] return nil unless there is a hook, otherwise boolean depending on success of hook
        def before
          return nil if self.blue_prints.before.empty?

          hook_action = HookAction.new(blue_prints: self.blue_prints.before, driver: self.driver, parent: self)
          return hook_action.run
        end

        #Runs the after hook
        # @return [Boolean, nil] return nil unless there is a hook, otherwise boolean depending on success of hook
        def after
          return nil if self.blue_prints.after.empty?

          hook_action = HookAction.new(blue_prints: self.blue_prints.after, driver: self.driver, parent: self)
          return hook_action.run
        end
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end