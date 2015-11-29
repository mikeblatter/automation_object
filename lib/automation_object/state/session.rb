require_relative 'window'

module AutomationObject
  module State
    #Store session details, methods for controlling viewing current driver session.
    class Session
      attr_accessor :driver, :composite, :current_window, :windows

      def initialize(args={})
        self.driver = args.fetch :driver
        self.composite = args.fetch :composite

        self.composite.session = self #Add self to the composite so it can communicate
        self.create_state
      end

      def current_window=(window)
        #Set window handle to the current one
        self.driver.window_handle = window.window_handle
        @current_window = window
      end

      def create_state
        self.driver.close_other_windows
        self.composite.create_state

        self.current_window = Window.new(driver: self.driver, composite: self.composite,
                                         screen_name: self.composite.initial_screen)
        self.windows = [self.current_window]
      end

      # Pass method on to driver, with maybe some extra work for caching, controlling windows!
      # @param method [Symbol] method to call
      # @param args [Array] arguments
      # @param block [Proc] block to run
      def method_missing(method, *args, &block)
        self.driver.send(method, *args, &block)
      end

      def load(type, name)
        case type
          when :screen
          when :modal
          when :element_group
          when :element_hash
          when :element_array
          when :element
        end
        ap type
        ap name
      end

      def quit
        puts "State::Session quit".colorize(:red)
      end
    end
  end
end