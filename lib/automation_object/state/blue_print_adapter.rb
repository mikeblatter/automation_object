require_relative 'blue_print_adapter/top'

module AutomationObject
  module State
    #State adapter for building DSL framework
<<<<<<< HEAD
    module BluePrintAdapter
      # @param args [Hash] expects :blue_prints
      # @return [AutomationObject::State::BlueAdapter::Top]
      def self.build_composite(args={})
        return Top.new(blue_prints: args.fetch(:blue_prints))
=======
    #Will work with the blueprints and adapter to accomplish the goal of maintaining the state
    #And give control of operations via the DSL
    module BluePrintAdapter
      # @param args [Hash] expects :blue_prints, :driver
      # @return [AutomationObject::State::BlueAdapter::Top]
      def self.build_composite(args={})
        return Top.new(blue_prints: args.fetch(:blue_prints), driver: args.fetch(:driver))
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end