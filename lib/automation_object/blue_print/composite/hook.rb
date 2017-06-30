# frozen_string_literal: true
# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # Hook composite class
      class Hook < Base
        # @return [AutomationObject::BluePrint::Composite::HookAction]
        def before
          adapter.before
        end

        # @return [AutomationObject::BluePrint::Composite::HookAction]
        def after
          adapter.after
        end

        # @return [Array<AutomationObject::BluePrint::Composite::HookElementRequirements>] array of element requirements
        def live?
          adapter.live?
        end

        # Get possible screen changes
        # @return [Array<Symbol>]
        def screen_changes
          [self.before.change_screen, self.before.new_screen,
                            self.after.change_screen, self.after.new_screen].uniq.compact
        end

        # Get possible modal changes
        # @return [Array<Symbol>]
        def modal_changes
          [self.before.show_modal, self.after.show_modal].uniq.compact
        end
      end
    end
  end
end
