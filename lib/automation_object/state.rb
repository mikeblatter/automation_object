require_relative 'state/session'

module AutomationObject
  #State Port, following port/adapter pattern
  #Composite adapts the state to the blueprint
  module State
    extend self

    # Creates/returns a new session, attaches driver, and composite
    # Will use a composite to help control the state
    # @param driver [AutomationObject::Driver::Driver] driver interface
    # @param blue_prints [AutomationObject::BluePrint::Composite::Top] Top composite interface
    #
    # @return [AutomationObject::State::Session] Session instance
    def new(driver, blue_prints)
      return Session.new(driver, blue_prints)
    end
  end
end