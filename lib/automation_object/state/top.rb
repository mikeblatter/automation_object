# frozen_string_literal: true

require_relative '_base'
require_relative '_error'

require_relative 'screen'

module AutomationObject
  module State
    # Top composite for managing state
    class Top < Base
      # Children for this composite
      # @return [Hash<Screen>]
      has_many :screens, interface: Screen

      # @param driver [AutomationObject::Driver] driver
      # @param blue_prints [AutomationObject::BluePrint::Composite::Base] blue print composite
      # @param name [Symbol] name of composite element
      # @param parent [Object, nil] parent composite object
      # @param location [String] string location for error/debugging purposes
      def initialize(driver, blue_prints, name = :top, parent = nil, location = 'top')
        super
      end

      # @return [Void]
      def start
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

          raise AutomationObject::State::NoInitialScreenError if screens[default_name].load.live? == false

          return screens[default_name].activate
        end

        screens.each_value do |screen|
          next unless screen.load.live?

          return screen.activate
        end

        raise AutomationObject::State::NoInitialScreenError
      end

      # @return [Hash<Screen>] active screens
      def active_screens
        screens.select { |_key, value| value.active? }
      end
    end
  end
end
