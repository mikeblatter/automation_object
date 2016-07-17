<<<<<<< HEAD
require_relative 'window'
=======
require_relative 'error'
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

module AutomationObject
  module State
    #Store session details, methods for controlling viewing current driver session.
    class Session
<<<<<<< HEAD
      attr_accessor :driver, :composite, :current_window, :windows
=======
      attr_accessor :driver, :composite
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

      def initialize(args={})
        self.driver = args.fetch :driver
        self.composite = args.fetch :composite

<<<<<<< HEAD
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
=======
        self.composite.create
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end

      def load(type, name)
        case type
          when :screen
<<<<<<< HEAD
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
=======
            unless self.composite.screen_exists?(name)
              raise AutomationObject::State::ScreenNotLiveError.new
            end

            self.composite.use_screen(name)
          when :modal
            #self.composite.use_model(name)
          when :element, :element_array, :element_hash, :element_group
            return self.composite.get_object(type, name)
          else
            raise AutomationObject::State::UndefinedLoadTypeError.new
        end
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end