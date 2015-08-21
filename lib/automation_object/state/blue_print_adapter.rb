require_relative 'blue_print_adapter/top'

module AutomationObject
  module State
    #State adapter for building DSL framework
    module BluePrintAdapter
      # @param args [Hash] expects :blue_prints
      # @return [AutomationObject::State::BlueAdapter::Top]
      def self.build_composite(args={})
        return Top.new(blue_prints: args.fetch(:blue_prints))
      end
    end
  end
end