require_relative '_base'

require_relative 'hook_action'
require_relative 'hook_actions/element_requirement'

module AutomationObject
  module State
    module Composite
      class Hook < Base
        # @return [Boolean, nil] return nil if no live? check, otherwise boolean
        def live?
          self.before

          return nil if self.blue_prints.live?.empty?

          self.blue_prints.live?.each { |element_requirement_blueprints|
            hook_element_requirement = ElementRequirement.new(element_requirement_blueprints,
                                                              driver, self, 1)
            return false unless hook_element_requirement.run
          }

          self.after

          return true
        end

        #Runs the before hook
        # @return [Boolean, nil] return nil unless there is a hook, otherwise boolean depending on success of hook
        def before
          return nil if self.blue_prints.before.empty?

          hook_action = HookAction.new(self.session,
                                       self.driver,
                                       self.blue_prints.before,
                                       :hook_action, self, self.location + '[hook_action]')

          return hook_action.run
        end

        #Runs the after hook
        # @return [Boolean, nil] return nil unless there is a hook, otherwise boolean depending on success of hook
        def after
          return nil if self.blue_prints.after.empty?

          hook_action = HookAction.new(self.session,
                                       self.driver,
                                       self.blue_prints.after,
                                       :hook_action, self, self.location + '[hook_action]')
          return hook_action.run
        end
      end
    end
  end
end