require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module BluePrintAdapter
      class NewScreen < ActionLoop
        def initialize(args = {})
          super
        end

        def single_run
          new_screen_name = self.blue_prints
          new_screen = self.composite.top.screens[new_screen_name]

          stored_window_handles = self.composite.top.window_handles
          driver_handles = self.driver.window_handles

          if driver_handles.length <= stored_window_handles.length
            return false
          end

          if (driver_handles.length - stored_window_handles.length) > 1
            raise MoreThenOneScreenCreated.new
          end

          self.composite.top.create_screen(new_screen_name)
          self.composite.top.use_screen(new_screen_name)

          self.driver.document_complete_wait

          return new_screen.load.live?
        end
      end
    end
  end
end