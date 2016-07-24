require_relative 'action_loop'

module AutomationObject
  module State
    module BluePrintAdapter
      class ResetScreen < ActionLoop
        def single_run
          unless self.composite.screen
            raise ScreenParentExpected.new
          end

          screen_name = self.composite.screen.name

        end
      end
    end
  end
end