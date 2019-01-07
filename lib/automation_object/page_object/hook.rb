# frozen_string_literal: true

module AutomationObject
  module PageObject
    class Hook
      # @return [AutomationObject::PageObject::HookAction]
      def before
        self.class._before
      end

      # @return [AutomationObject::PageObject::HookAction]
      def after
        self.class._after
      end

      # @return [Array<AutomationObject::PageObject::HookElementRequirement>]
      def live?
        self.class._live
      end

      class << self
        attr_reader :_before, :_after, :_live

        # @param [AutomationObject::PageObject::HookAction] hook_action
        def before(hook_action)
          @_before = hook_action
        end

        # @param [AutomationObject::PageObject::HookAction] hook_action
        def after(hook_action)
          @_after = hook_action
        end

        # @param [Array<AutomationObject::PageObject::HookElementRequirement>] hook_element_requirements
        def live?(hook_element_requirements)
          @_live = hook_element_requirements
        end
      end
    end
  end
end
