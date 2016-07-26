require_relative 'blue_print_adapter/top'

module AutomationObject
  module State
    #State adapter for building DSL framework
    #Will work with the blueprints and adapter to accomplish the goal of maintaining the state
    #And give control of operations via the DSL
    module BluePrintAdapter
      # @param args [Hash] expects :blue_prints, :driver
      # @return [AutomationObject::State::BlueAdapter::Top]
      def self.build(args={})
        return Top.new(args.fetch(:blue_prints), args.fetch(:driver))
      end
    end
  end
end