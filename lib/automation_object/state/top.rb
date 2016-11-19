# frozen_string_literal: true
require_relative '_base'
require_relative '_error'

require_relative 'screen'

module AutomationObject
  module State
    # Top composite for managing state
    class Top < Base
      # Children for this composite
      has_many :screens, interface: Screen

      def initialize(*args)
        super(*args)

        driver.get(blue_prints.base_url) if blue_prints.base_url
        set_initial_screen
      end

      # Get the initial screen
      # @raise [AutomationObject::State::NoInitialScreenError] if no initial screen
      # @return [Symbol] screen name
      def set_initial_screen
        # If default screen then check if its live and set it
        if blue_prints.default_screen
          default_name = blue_prints.default_screen

          raise AutomationObject::State::NoInitialScreenError if screens[default_name].load.live? != true

          return screens[default_name].activate
        end

        screens.each_value do |screen|
          next unless screen.load.live?
          return screen.activate
        end

        raise AutomationObject::State::NoInitialScreenError
      end
    end
  end
end
