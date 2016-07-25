require_relative 'parse'

module AutomationObject
  module StepDefinitions
    class Action
      attr_accessor :args, :automation_object

      def initialize(*args)
        #Parse arguments
        self.args = AutomationObject::StepDefinitions::Parse.new(args).get
      end

      def automation_object
        return @automation_object if @automation_object

        @automation_object = AutomationObject::Framework.get
        return @automation_object
      end
    end
  end
end