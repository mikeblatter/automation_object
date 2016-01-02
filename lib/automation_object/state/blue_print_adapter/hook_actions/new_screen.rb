require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module BluePrintAdapter
      class NewScreen < ActionLoop
        def initialize(args = {})
          super
          self.loops = 1
        end

        def single_run
          new_screen_name = self.blue_prints
          new_screen = self.composite.top.screens[new_screen_name]

          stored_window_handles = self.composite.top.window_handles
          driver_handles = []
          30.times do
            sleep(1)
            driver_handles = self.driver.window_handles
            break if driver_handles.length > stored_window_handles
          end

          if driver_handles.length <= stored_window_handles.length
            raise 'Expecting new window to exist'
          end

          if (driver_handles.length - stored_window_handles.length) > 1
            raise 'Only expecting one window to open'
          end

          self.composite.top.create_screen(new_screen_name)
          self.composite.top.use_screen(new_screen_name)

          self.driver.document_complete_wait

          unless new_screen.load.live?
            raise AutomationObject::State::ScreenNotLiveError.new
          end
        end
      end
    end
  end
end