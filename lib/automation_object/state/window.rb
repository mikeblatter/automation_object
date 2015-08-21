module AutomationObject
  module State
    #Window object for containing stored elements, etc...
    class Window
      attr_accessor :driver, :window_handle, :screen_name

      def initialize(args={})
        self.driver = args.fetch :driver
        self.screen_name = args.fetch :screen_name

        self.window_handle = self.driver.window_handle #Set to current window handle
      end
    end
  end
end