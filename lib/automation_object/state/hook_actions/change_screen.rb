# frozen_string_literal: true

require_relative 'action_loop'

module AutomationObject
  module State
    # Change screen hook loop
    class ChangeScreen < ActionLoop
      def single_run
        return false unless driver.document_complete?

        new_screen = composite.top.screens[blue_prints]
        return false if new_screen.load.live? == false # Need strict

        new_screen.previous_screen_name = composite.screen.name

        composite.screen.deactivate
        new_screen.activate

        true
      end
    end
  end
end
