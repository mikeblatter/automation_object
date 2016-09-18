require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      class CloseScreen < ActionLoop
        def single_run
          unless self.composite.screen
            raise ScreenParentExpected.new
          end

          screen_name = self.composite.screen.name
          return self.composite.top.window_closed?(screen_name)
        end
      end
    end
  end
end
