require_relative 'action_loop'

module AutomationObject
  module State
    module BluePrintAdapter
      class ChangeToPreviousScreen < ActionLoop
        def single_run
          self.driver.document_complete_wait

          new_screen = self.composite.top.current_window.previous_screen_name
          if new_screen.load.live?
            self.composite.top.set_screen(new_screen)
            return true
          else
            return false
          end
        end
      end
    end
  end
end