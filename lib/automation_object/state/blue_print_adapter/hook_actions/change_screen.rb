require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module BluePrintAdapter
      class ChangeScreen < ActionLoop
        def initialize(args = {})
          super
          self.loops = 1
        end

        def single_run
          new_screen_name = self.blue_prints
          ap new_screen_name
          self.driver.document_complete_wait

          new_screen = self.composite.top.screens[new_screen_name]
          if new_screen.load.live?
            self.composite.top.set_screen(new_screen)
          else
            raise AutomationObject::State::ScreenNotLiveError.new
          end
        end
      end
    end
  end
end