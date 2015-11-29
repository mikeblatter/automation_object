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
        @windows_screens[@window_handle] = screen
      end

      def destroy
        #@driver.close_other_windows
      end
    end
  end
end