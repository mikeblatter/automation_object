# frozen_string_literal: true

# Require parent class
require_relative 'base'

require_relative 'hook_element_requirements'

module AutomationObject
  module BluePrint
    module Composite
      # HookAction composite class
      class HookAction < Base
        # Get the order to run the hook in
        # @return [Array<Symbol>] list of hook methods to run in given order
        def hook_order
          adapter.hook_order
        end

        # Get length of hook actions
        # @return [Integer] length of hook actions
        def length
          adapter.length
        end

        # See if hook actions are empty
        # @return [Boolean] if hook actions are empty
        def empty?
          adapter.empty?
        end

        # @return [Symbol, nil] screen to change to
        def change_screen
          adapter.change_screen
        end

        # @return [Symbol, nil] new screen
        def new_screen
          adapter.new_screen
        end

        # @return [Boolean]
        def close_screen
          adapter.close_screen
        end

        # @return [Boolean]
        def close_modal
          adapter.close_modal
        end

        # @return [Boolean]
        def change_to_previous_screen
          adapter.change_to_previous_screen
        end

        # @return [Symbol, nil]
        def show_modal
          adapter.show_modal
        end

        # @return [Array]
        def possible_screen_changes
          adapter.possible_screen_changes
        end

        # @return [Boolean] reset the screen?
        def reset_screen
          adapter.reset_screen
        end

        # @return [Numeric] amount of time to sleep
        def sleep
          adapter.sleep
        end

        # Custom method for array of children instead of Hash
        # @return [Array<AutomationObject::BluePrint::Composite::HookElementRequirements>] array of wait for element children
        def wait_for_elements
          adapter.wait_for_elements
        end
      end
    end
  end
end
