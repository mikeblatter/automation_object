# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      # Show modal hook loop
      class ShowModal < ActionLoop
        def single_run
          new_modal = composite.screen.modals[blue_prints]

          if new_modal.load.live? != false
            composite.screen.current_modal = blue_prints
            composite.screen.modal = new_modal
            return true
          else
            return false
          end
        end
      end
    end
  end
end
