require_relative 'blue_print_adapter/top'

module AutomationObject
  module State
    #State adapter for building DSL framework
    #Will work with the blueprints and adapter to accomplish the goal of maintaining the state
    #And give control of operations via the DSL
    module BluePrintAdapter
      # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
      # @param [AutomationObject::Driver::Driver] driver
      # @return [AutomationObject::State::BlueAdapter::Top]
      def self.build(blue_prints, driver)
        return Top.new(blue_prints, driver)
      end
    end
  end
end