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
            self.composite.request_screen(name)
          when :modal
            self.composite.request_modal(name)
          when :element, :element_array, :element_hash, :element_group
            return self.composite.request_object(type, name)
          else
            raise AutomationObject::State::UndefinedLoadTypeError.new
        end
      end
    end
  end
end