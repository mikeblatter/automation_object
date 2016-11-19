# frozen_string_literal: true
require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      # Close screen hook loop
      class CloseScreen < ActionLoop
        def single_run
          raise ScreenParentExpected unless composite.screen

          screen_name = composite.screen.name
          window = composite.top.window_by_name(screen_name)
          return false unless window.closed?

          composite.top.close(screen_name)

          true
        end
      end
    end
  end
end
