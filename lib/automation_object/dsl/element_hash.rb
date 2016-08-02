require_relative 'base'

module AutomationObject
  module Dsl
    class ElementHash < Base
      # @param [AutomationObject::BluePrint::Composite::ElementHash] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        super(blue_prints, state, Model::ElementHash.new)
      end
    end
  end
end