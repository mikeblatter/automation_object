require_relative 'composite'
require_relative 'screen'

require_relative 'helpers/screen_manager'

require_relative '../error'

module AutomationObject
  module State
    module BluePrintAdapter
      class Top < Composite
        include ScreenManager

        #Children for this composite
        has_many :screens, interface: Screen

        # @return [Symbol] symbol of the initial screen found
        def create
          self.driver.get(self.blue_prints.base_url) if self.blue_prints.base_url
          self.set_screen(self.initial_screen)
        end

        def initial_screen
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