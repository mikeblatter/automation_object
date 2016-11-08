# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      # Change to previous screen hook loop
      class ChangeToPreviousScreen < ActionLoop
        def single_run
          return false unless driver.document_complete?

          new_screen = composite.top.window.previous
          if new_screen.load.live?
            composite.top.window.update(new_screen)
            return true
          else
            return false
          end
        end
      end
    end
  end
end
