# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      # Change screen hook loop
      class ChangeScreen < ActionLoop
        def single_run
          return false unless driver.document_complete?

          new_screen = composite.top.screens[blue_prints]
          if new_screen.load.live? != false # Need strict
            composite.top.window.update(blue_prints)
            return true
          else
            return false
          end

        end
      end
    end
  end
end
