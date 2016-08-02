require_relative 'base'

module AutomationObject
  module Dsl
    class Element < Base
      # @param [AutomationObject::BluePrint::Composite::Element] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        @subject = Model::Element.new
        super
      end
    end
  end
end