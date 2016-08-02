require_relative 'base'
require_relative 'screen'

module AutomationObject
  module Dsl
    class Top < Base

      # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        has_many :screens, Screen
        super(blue_prints, state, Model::Top.new)
      end
    end
  end
end