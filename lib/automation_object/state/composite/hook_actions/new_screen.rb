require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      class NewScreen < ActionLoop
        def initialize(args = {})
          super
        end

        def single_run
          new_screen_name = blue_prints
          new_screen = composite.top.screens[new_screen_name]

          stored_window_handles = composite.top.window_handles
          driver_handles = driver.window_handles

          return false if driver_handles.length <= stored_window_handles.length

          if (driver_handles.length - stored_window_handles.length) > 1
            raise MoreThenOneScreenCreated
          end

          composite.top.create_screen(new_screen_name)
          composite.top.use_screen(new_screen_name)

          return false unless driver.document_complete?

          new_screen.load.live?
        end
      end
    end
  end
end
