# frozen_string_literal: true

require_relative 'dsl/top'
require_relative 'state/top'

module AutomationObject
  # Dsl Port
  module Dsl
    module_function

    # @param blue_prints [AutomationObject::BluePrint::Composite::Top]  top blue print
    # @param state [AutomationObject::State::Top] top state
    # @return [AutomationObject::Dsl::Top]
    def create(blue_prints, state)
      TopProxy.new(blue_prints, state, :top)
    end
  end
end
