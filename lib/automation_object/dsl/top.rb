# frozen_string_literal: true
require_relative '_base'
require_relative '_proxy'

require_relative 'screen'

module AutomationObject
  module Dsl
    # Top DSL Class
    class Top < Base
      has_many :screens, ScreenProxy
    end

    # Proxy for Top Composite
    # Use proxy for methods trying to do a @state call
    class TopProxy < Proxy
      # @param blue_prints [AutomationObject::BluePrint::Composite::Top]
      # @param state [AutomationObject::State::Top] top composite
      # @param name [Symbol]
      def initialize(blue_prints, state, name)
        super Top, blue_prints, state, name
      end

      def active?
        true
      end
    end
  end
end
