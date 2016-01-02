require_relative 'hook_actions/change_screen'
require_relative 'hook_actions/change_to_previous_screen'
require_relative 'hook_actions/close_modal'
require_relative 'hook_actions/close_window'
require_relative 'hook_actions/possible_screen_changes'
require_relative 'hook_actions/reset_screen'
require_relative 'hook_actions/show_modal'
require_relative 'hook_actions/sleep'
require_relative 'hook_actions/wait_for_elements'
require_relative 'hook_actions/new_screen'

module AutomationObject
  module State
    module BluePrintAdapter
      class HookAction < Composite
        def initialize(args = {})
          super(args)
        end

        # @return [Boolean] run success or not
        def run
          self.blue_prints.hook_order.each { |hook_name|
            hook_action_class = AutomationObject::State::BluePrintAdapter.const_get(hook_name.to_s.pascalize)
            blue_prints = self.blue_prints.send(hook_name)

            hook_action = hook_action_class.new(blue_prints: blue_prints, composite: self)
            hook_action.run
          }
        end
      end
    end
  end
end