# frozen_string_literal: true
require_relative 'dsl/top'

module AutomationObject
  # Dsl Port
  module Dsl
    extend self

    # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
    # @param [AutomationObject::State::Session] state
    # @return [AutomationObject::Dsl::Top]
    def new(blue_prints, state)
      TopProxy.new(blue_prints, state, :top)
    end
  end
end
