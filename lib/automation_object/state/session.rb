require_relative 'window_manager'
require_relative 'error'

module AutomationObject
  module State
    #Store session details, methods for controlling viewing current driver session.
    class Session
      attr_accessor :driver, :composite, :window_manager

      def initialize(args={})
        self.driver = args.fetch :driver
        self.composite = args.fetch :composite

        self.window_manager = WindowManager.new(driver: self.driver, composite: self.composite)

        self.window_manager.create
        self.window_manager.set_screen(self.composite.create)
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
            #self.window_manager.use_model(name)
          when :element, :element_array, :element_hash, :element_group
            return self.window_manager.get_object(type, name)
          else
            raise AutomationObject::State::UndefinedLoadTypeError.new
        end
      end

      def quit
        self.composite.destroy
        self.window_manager.destroy
      end
    end
  end
end