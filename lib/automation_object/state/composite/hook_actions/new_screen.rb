# frozen_string_literal: true
require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      # New screen hook loop
      class NewScreen < ActionLoop
        # @param composite [AutomationObject::State::Composite::Base]
        # @param driver [AutomationObject::Driver::Driver]
        # @param blue_prints [AutomationObject::BluePrint::Composite::Base]
        # @param loops [Integer]
        def initialize(composite, driver, blue_prints, loops = 1)
          self.composite = composite
          self.driver = driver
          self.blue_prints = blue_prints
          self.loops = loops
        end

        def single_run
          new_screen_name = blue_prints
          new_screen = composite.top.screens[new_screen_name]

          stored_window_handles = composite.top.window_handles
          driver_handles = driver.window_handles

          return false if driver_handles.length <= stored_window_handles.length

          raise MoreThenOneScreenCreated if (driver_handles.length - stored_window_handles.length) > 1

          composite.top.new_window(new_screen_name)
          composite.top.use(new_screen_name)

          30.times do
            next unless driver.document_complete?
            next unless new_screen.load.live?

            return true
          end

          return false
        end
      end
    end
  end
end
