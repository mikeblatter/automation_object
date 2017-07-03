# frozen_string_literal: true

require_relative 'action_loop'

module AutomationObject
  module State
    # Change to previous screen hook loop
    class ChangeToPreviousScreen < ActionLoop
      def single_run
        return false unless driver.document_complete?

        new_screen = composite.top.screens[composite.screen.previous_screen_name]
        # Need strict check, can be nil
        return false if new_screen.load.live? == false

        new_screen.previous_screen_name = composite.screen.name
        composite.screen.deactivate
        new_screen.activate

        true
      end
    end
  end
end
