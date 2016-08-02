require_relative 'base'
require_relative 'screen'

module AutomationObject
  module Dsl
    class Top < Base
      has_many :screens, Screen

      # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        @subject = Model::Top.new
        super
      end
    end
  end
end