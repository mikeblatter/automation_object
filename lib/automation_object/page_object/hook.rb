# frozen_string_literal: true

require_relative 'base'

module AutomationObject
  module PageObject
    class Hook
      include AutomationObject::PageObject::Base

      # @return [AutomationObject::PageObject::HookAction]
      def before
        self.class.options[:before]
      end

      # @return [AutomationObject::PageObject::HookAction]
      def after
        self.class.options[:after]
      end

      # @return [Array<AutomationObject::PageObject::HookElementRequirement>]
      def live?
        self.class.options[:live]
      end

      class << self
        # @param [AutomationObject::PageObject::HookAction] hook_action
        def before(hook_action)
          options[:before] = hook_action
        end

        # @param [AutomationObject::PageObject::HookAction] hook_action
        def after(hook_action)
          options[:after] = hook_action
        end

        # @param [Array<AutomationObject::PageObject::HookElementRequirement>] hook_element_requirements
        def live?(hook_element_requirements)
          options[:live] = hook_element_requirements
        end
      end
    end
  end
end
