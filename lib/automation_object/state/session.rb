require_relative 'error'

module AutomationObject
  module State
    #Store session details, methods for controlling viewing current driver session.
    class Session
      attr_accessor :driver, :composite

      def initialize(args={})
        self.driver = args.fetch :driver
        self.composite = args.fetch :composite

        self.composite.create
      end

      def load(type, name)
        case type
          when :screen
            unless self.composite.screen_exists?(name)
              raise AutomationObject::State::ScreenDoesNotExistError.new
            end

            self.composite.use_screen(name)
          when :modal
            #self.composite.use_model(name)
          when :element, :element_array, :element_hash, :element_group
            return self.composite.get_object(type, name)
          else
            raise AutomationObject::State::UndefinedLoadTypeError.new
        end
      end
    end
  end
end