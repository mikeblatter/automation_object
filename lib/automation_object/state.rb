require_relative 'state/session'
require_relative 'state/composite'

module AutomationObject
  #State Port, following port/adapter pattern
  #Composite adapts the state to the blueprint
  module State
    extend self

    # Creates/returns a new session, attaches driver, and composite
    # Will use a composite to help control the state
    # @param blue_prints [AutomationObject::BluePrint::Composite::Top] Top composite interface
    # @param driver [AutomationObject::Driver::Driver] driver interface
    #
    # @return [AutomationObject::State::Session] Session instance
    def new(blue_prints, driver)
      return Session.new(driver: driver, composite: Composite.build(blue_prints, driver))
    end
  end
end