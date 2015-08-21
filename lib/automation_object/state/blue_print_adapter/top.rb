require_relative 'composite'

require_relative 'screen'

module AutomationObject
  module State
    module BluePrintAdapter
      class Top < Composite
        #Children for this composite
        has_many :screens, interface: Screen

        def create_state
          self.session.get(self.blue_prints.base_url) if self.blue_prints.base_url
        end

        def initial_screen
          return self.blue_prints.default_screen if self.blue_prints.default_screen

          self.screens.each { |screen_name, screen|
            return screen_name if screen.load.live?
          }
        end
      end
    end
  end
end