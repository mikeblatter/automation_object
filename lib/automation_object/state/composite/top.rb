# frozen_string_literal: true
require_relative '../error'

require_relative '_base'
require_relative 'screen'

require_relative 'helpers/window_manager'

module AutomationObject
  module State
    module Composite
      # Top composite for managing state
      class Top < Base
        include WindowManager

        # Children for this composite
        has_many :screens, interface: Screen

        def initialize(*args)
          super(*args)

          driver.get(blue_prints.base_url) if blue_prints.base_url
          new_window(initial_screen)
        end

        def current_screen
          screens[window.name]
        end

        # Get the initial screen
        # @raise [AutomationObject::State::NoInitialScreenError] if no initial screen
        # @return [Symbol] screen name
        def initial_screen
          # If default screen then check if its live and set it
          if blue_prints.default_screen
            default_name = blue_prints.default_screen
            return default_name if screens[default_name].load.live? != false

            raise AutomationObject::State::NoInitialScreenError
          end

          screens.each do |screen_name, screen|
            return screen_name if screen.load.live?
          end

          raise AutomationObject::State::NoInitialScreenError
        end
      end
    end
  end
end
