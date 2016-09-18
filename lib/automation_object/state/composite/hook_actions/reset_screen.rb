require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      class ResetScreen < ActionLoop
        def single_run
          raise ScreenParentExpected unless composite.screen
        end
      end
    end
  end
end
