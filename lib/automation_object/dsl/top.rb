require_relative '_base'
require_relative '_proxy'

require_relative 'screen'

module AutomationObject
  module Dsl
    class Top < Base
      has_many :screens, ScreenProxy
    end

    class TopProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super Top.new(blue_prints, state, name)
      end
    end
  end
end