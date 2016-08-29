require_relative 'error'

module AutomationObject
  module State
    class Window
      # @param [AutomationObject::Driver::Driver] driver
      # @param [String] handle
      # @param [Symbol] screen
      def initialize(driver, handle, screen)
        @driver = driver
        @handle = handle

        #Use to control history
        @position = 0
        @history = [screen]
      end

      # @return [Symbol] current screen
      def screen
        @history[@position]
      end

      def use
        return if @driver.window_handle == @handle
        @driver.window_handle = @handle
      end

      def back
        raise CannotNavigateBack.new if @position == 0

        @driver.back
        @position -= 1
      end

      def forward
        raise CannotNavigateForward.new if @position >= @history.length

        @driver.forward
        @position += 1
      end

      def closed?
        !@driver.window_handles.include?(self.window_handle)
      end

      #Close the window
      def close
        @driver.close
      end
    end
  end
end