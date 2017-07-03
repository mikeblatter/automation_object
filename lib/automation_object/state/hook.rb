# frozen_string_literal: true

require_relative '_base'

require_relative 'hook_action'
require_relative 'hook_actions/element_requirement'

module AutomationObject
  module State
    # Hook composite for managing state
    class Hook < Base
      # @return [Boolean, nil] return nil if no live? check, otherwise boolean
      def live?
        before

        return nil if blue_prints.live?.empty?

        blue_prints.live?.each do |element_requirement_blueprints|
          hook_element_requirement = ElementRequirement.new(self, driver, element_requirement_blueprints, 1)
          return false unless hook_element_requirement.run
        end

        after

        true
      end

      # Runs the before hook
      # @return [Boolean, nil] return nil unless there is a hook, otherwise boolean depending on success of hook
      def before
        return nil if blue_prints.before.empty?

        hook_action = HookAction.new(driver,
                                     blue_prints.before,
                                     :hook_action, self, location + '[hook_action]')

        hook_action.run
      end

      # Runs the after hook
      # @return [Boolean, nil] return nil unless there is a hook, otherwise boolean depending on success of hook
      def after
        return nil if blue_prints.after.empty?

        hook_action = HookAction.new(driver,
                                     blue_prints.after,
                                     :hook_action, self, location + '[hook_action]')
        hook_action.run
      end
    end
  end
end
