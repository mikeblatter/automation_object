# Require parent class
require_relative 'base'

require_relative 'hook_element_requirements'

module AutomationObject
  module BluePrint
    module Composite
      # HookAction composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class HookAction < Base
        # Get the order to run the hook in
        # @return [Array<Symbol>] list of hook methods to run in given order
        def hook_order
          self.adapter.hook_order
        end

        # Get length of hook actions
        # @return [Integer] length of hook actions
        def length
          self.adapter.length
        end

        # See if hook actions are empty
        # @return [Boolean] if hook actions are empty
        def empty?
          self.adapter.empty?
        end

        # @return [Symbol, nil] screen to change to
        def change_screen
          self.adapter.change_screen
        end

        # @return [Symbol, nil] new screen
        def new_screen
          self.adapter.new_screen
        end

        # @return [Boolean]
        def close_screen
          self.adapter.close_screen
        end

        # @return [Boolean]
        def close_modal
          self.adapter.close_modal
        end

        # @return [Boolean]
        def change_to_previous_screen
          self.adapter.change_to_previous_screen
        end

        # @return [Symbol, nil]
        def show_modal
          self.adapter.show_modal
        end

        # @return [Array]
        def possible_screen_changes
          self.adapter.possible_screen_changes
        end

        # @return [Boolean] reset the screen?
        def reset_screen
          self.adapter.reset_screen
        end

        # @return [Numeric] amount of time to sleep
        def sleep
          self.adapter.sleep
        end

        # Custom method for array of children instead of Hash
        # @return [Array<HookElementRequirements>] array of wait for element children
        def wait_for_elements
          self.adapter.wait_for_elements
        end
      end
    end
  end
end
