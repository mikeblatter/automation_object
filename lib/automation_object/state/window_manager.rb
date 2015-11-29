require_relative 'error'

module AutomationObject
  module State
    #Manages the driver windows
    class WindowManager
      def initialize(args = {})
        @driver = args.fetch(:driver)
        @windows_screens = {}
      end

      def create
        @driver.close_other_windows
        @window_handle = @driver.window_handle
      end

      def set_screen(screen)
        @windows_screens[screen] = @window_handle
      end

      def use_screen(screen)
        raise ScreenDoesNotExistError unless @windows_screens.keys.include?(screen)

        return if @window_handle == @windows_screens[screen]

        @driver.window_handle = @windows_screens[screen]
        @window_handle = @windows_screens[screen]
      end

      def destroy
        #@driver.close_other_windows
      end
    end
  end
end