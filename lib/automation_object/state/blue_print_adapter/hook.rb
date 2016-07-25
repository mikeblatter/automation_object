require_relative 'composite'

require_relative 'hook_action'
require_relative 'hook_actions/element_requirement'

module AutomationObject
  module State
    module BluePrintAdapter
      class Hook < AutomationObject::State::BluePrintAdapter::Composite
        # @return [Boolean, nil] return nil if no live? check, otherwise boolean
        def live?
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

          hook_action = HookAction.new(self.blue_prints.before,
                                       self.driver,
                                       :hook_action,
                                       self,
                                       self.location + '[hook_action]')
          return hook_action.run
        end

        #Runs the after hook
        # @return [Boolean, nil] return nil unless there is a hook, otherwise boolean depending on success of hook
        def after
          return nil if self.blue_prints.after.empty?

          hook_action = HookAction.new(self.blue_prints.after,
                                       self.driver,
                                       :hook_action,
                                       self,
                                       self.location + '[hook_action]')
          return hook_action.run
        end
      end
    end
  end
end