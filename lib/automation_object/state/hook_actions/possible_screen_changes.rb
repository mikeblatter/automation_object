# frozen_string_literal: true

require_relative 'action_loop'

module AutomationObject
  module State
    # Possible screen changes hook loop
    class PossibleScreenChanges < ActionLoop
      def single_run
        return false unless driver.document_complete?

        blue_prints.each do |possible_screen_name|
          new_screen = composite.top.screens[possible_screen_name]
          next unless new_screen.load.live? != false
          composite.screen.deactivate
          new_screen.activate
          return true
        end

        false
      end
    end
  end
end
