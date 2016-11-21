# frozen_string_literal: true
require_relative 'state/top'

module AutomationObject
  # State Port, following port/adapter pattern
  # Composite adapts the state to the blueprint
  module State
    module_function

    # Creates/returns a new session, attaches driver, and composite
    # Will use a composite to help control the state
    # @param driver [AutomationObject::Driver::Driver] driver interface
    # @param blue_prints [AutomationObject::BluePrint::Composite::Top] Top composite interface
    # # @return [AutomationObject::State::Top] Top instance
    def create(driver, blue_prints)
      top = Top.new(driver, blue_prints)
      top.start

      top
    end
  end
end
