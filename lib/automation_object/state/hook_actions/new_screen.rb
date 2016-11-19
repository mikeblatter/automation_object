# frozen_string_literal: true
require_relative 'action_loop'
require_relative '../_error'

module AutomationObject
  module State
    # New screen hook loop
    class NewScreen < ActionLoop
      # @param composite [AutomationObject::State::Base]
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
        new_screen = composite.top.screens[blue_prints]
        stored_window_handles = composite.top.screens.values
                                         .each_with_object([]) do |screen, a|
          a.push(screen.window_handle) unless screen.window_handle.nil?
          a
        end

        driver_handles = driver.window_handles

        return false if driver_handles.length <= stored_window_handles.length
        raise MoreThenOneScreenCreated if (driver_handles.length - stored_window_handles.length) > 1

        new_window_handle = (driver_handles - stored_window_handles)[0]
        driver.window_handle = new_window_handle

        30.times do
          next unless driver.document_complete?
          next if new_screen.load.live? == false

          new_screen.activate

          return true
        end

        false
      end
    end
  end
end
