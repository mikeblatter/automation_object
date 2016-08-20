require_relative 'action_loop'

module AutomationObject
  module State
    module BluePrintAdapter
      class ResetScreen < ActionLoop
        def single_run
          unless self.composite.screen
            raise ScreenParentExpected.new
          end
        end
      end
    end
  end
end