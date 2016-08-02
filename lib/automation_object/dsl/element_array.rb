require_relative 'base'

module AutomationObject
  module Dsl
    class ElementArray < Base
      # @param [AutomationObject::BluePrint::Composite::ElementArray] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        @subject = Model::ElementArray.new
        super
      end
    end
  end
end