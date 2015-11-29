require_relative 'window_manager'

module AutomationObject
  module State
    #Store session details, methods for controlling viewing current driver session.
    class Session
      attr_accessor :driver, :composite, :window_manager

      def initialize(args={})
        self.driver = args.fetch :driver
        self.composite = args.fetch :composite

        self.window_manager = WindowManager.new(driver: self.driver)
        self.composite.session = self

        self.window_manager.create
        self.composite.create
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
            self.window_manager.use_screen(name)
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
        self.composite.destroy
        self.window_manager.destroy
      end
    end
  end
end