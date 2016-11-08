# frozen_string_literal: true
require_relative 'window'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      # Collection to manage Window objects
      module WindowManager
        # @param name [Symbol] name of window to use
        # @return [void]
        def use(name)
          raise AutomationObject::State::ScreenNotActiveError, name unless live_screens.include?(name)

          windows.each do |window|
            next if window.name != name
            return if window == self.window

            @window = window
            @window.use
          end
        end

        # @return [AutomationObject::State::Composite::Window]
        def window
          raise AutomationObject::State::Error::NoActiveWindows unless @window
          @window
        end

        # @return [Array<Window>]
        def windows
          @windows ||= []
        end

        # @return [Array<String>] list of stored window handles
        def window_handles
          windows.map(&:handle)
        end

        # @return [Array<String>] list of stored screen names
        def live_screens
          windows.map(&:name)
        end

        # @return [void]
        def new_window(name)
          driver_handles = driver.window_handles
          diff_handles = driver_handles - window_handles

          # Should only have one extra window
          raise UnexpectedExtraWindowError if diff_handles.length > 1

          @window = Window.new(driver, diff_handles.first, name)
          windows << @window
        end
      end
    end
  end
end
