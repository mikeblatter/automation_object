require_relative 'session'

module AutomationObject
  module State
    class Controller
      attr_accessor :session

      # @param args [Hash] params
      def initialize(args={})
        self.session = Session.new(driver: args.fetch(:driver), composite: args.fetch(:composite))
      end

      # @param type [Symbol] type of object to load, screen, element, etc...
      # @param name [Symbol] name of the object
      def load(type, name)
        return self.session.load(type, name)
      end
    end
  end
end