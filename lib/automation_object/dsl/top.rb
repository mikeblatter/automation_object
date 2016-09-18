require_relative '_base'
require_relative '_proxy'

require_relative 'screen'

module AutomationObject
  module Dsl
    class Top < Base
      has_many :screens, ScreenProxy
    end

    # Proxy for Top Composite
    # Use proxy for methods trying to do a @state call
    class TopProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super Top, blue_prints, state, name
      end

      def active_screens
        @state
      end
    end
  end
end
