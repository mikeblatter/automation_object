require_relative 'base'

module AutomationObject
  module Dsl
    class Element < Base
      # @param [AutomationObject::BluePrint::Composite::Element] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        super(blue_prints, state, Model::Element.new)
      end
    end
  end
end