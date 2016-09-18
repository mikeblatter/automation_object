require_relative '../error'

require_relative '_base'
require_relative 'screen'

require_relative 'helpers/window_manager'

module AutomationObject
  module State
    module Composite
      class Top < Base
        include WindowManager

        # Children for this composite
        has_many :screens, interface: Screen

        def initialize(*args)
          super(*args)

          self.driver.get(self.blue_prints.base_url) if self.blue_prints.base_url
          self.new_window(self.initial_screen)
        end

        # Get the initial screen
        # @raise [AutomationObject::State::NoInitialScreenError] if no initial screen
        # @return [Symbol] screen name
        def initial_screen
          # If default screen then check if its live and set it
          if self.blue_prints.default_screen
            screen_name = self.blue_prints.default_screen
            default_screen_live = self.screens[screen_name].load.live?

            if default_screen_live == nil or default_screen_live == true
              return screen_name
            else
              raise AutomationObject::State::NoInitialScreenError.new
            end
          end

          self.screens.each { |screen_name, screen|
            return screen_name if screen.load.live?
          }

          raise AutomationObject::State::NoInitialScreenError.new
        end
      end
    end
  end
end
