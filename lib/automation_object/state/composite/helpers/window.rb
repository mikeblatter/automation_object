# frozen_string_literal: true
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      # Window class
      class Window
        # @param [AutomationObject::Driver::Driver] driver
        # @param [String] handle
        # @param [Symbol] screen
        def initialize(driver, handle, screen)
          @driver = driver
          @handle = handle

          # Use to control history
          @position = 0
          @history = [screen]
        end

        # @return [Symbol] current screen
        def name
          @history[@position]
        end

        # @return [void]
        def use
          return if @driver.window_handle == @handle
          @driver.window_handle = @handle
        end

        # @return [void]
        def back
          raise CannotNavigateBack if @position.zero?

          @driver.back
          @position -= 1
        end

        # @return [void]
        def forward
          raise CannotNavigateForward if @position >= @history.length

          @driver.forward
          @position += 1
        end

        # @return [Boolean]
        def closed?
          !@driver.window_handles.include?(window_handle)
        end

        # Close the window
        # @return [void]
        def close
          @driver.close
        end
      end
    end
  end
end
