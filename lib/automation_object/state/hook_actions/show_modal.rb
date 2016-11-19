# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    # Show modal hook loop
    class ShowModal < ActionLoop
      def single_run
        new_modal = composite.screen.modals[blue_prints]

        return false if new_modal.load.live? == false

        new_modal.activate
        true
      end
    end
  end
end
