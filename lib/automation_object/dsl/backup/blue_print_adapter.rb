require_relative 'blue_print_adapter/top'

module AutomationObject
  module Dsl
    #BluePrint adapter for building DSL framework
    #Follows similar pattern to BluePrint::HashAdapter composite
    module BluePrintAdapter
      # @param args [Hash] expects :blue_prints, :state
      # @return [AutomationObject::Dsl::Models::Top]
      def self.build(args={})
        blue_print_adapter = Top.new(blue_prints: args.fetch(:blue_prints))
        return blue_print_adapter.build
      end
    end
  end
end