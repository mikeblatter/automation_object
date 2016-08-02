require_relative 'state/session'

module AutomationObject
  #State Port, following port/adapter pattern
  #BluePrintAdapter adapts the state to the blueprint
  module State
    extend self

    # @return [AutomationObject::State::BluePrintAdapter::Top]
    def adapter
      return @adapter if @adapter
      self.adapter = :blue_print
      @adapter
    end

    # Sets adapter const will append _adapter if needed
    # @param adapter_name [String] name of adapter wanted for composite creation
    def adapter=(adapter_name)
      adapter_name = adapter_name.to_s
      adapter_name << '_adapter' unless adapter_name.match(/_adapter$/)
      adapter_const = adapter_name.pascalize

      require_relative "state/#{adapter_name}"
      @adapter = AutomationObject::State.const_get("#{adapter_const}")
    end

    # Creates/returns a new session, attaches driver, and composite adapter
    # Will use a composite to direct the other layers (ie BluePrint)
    # @param blue_prints [AutomationObject::BluePrint::Composite::Top] Top composite interface
    # @param driver [AutomationObject::Driver::Driver] driver interface
    # @return [AutomationObject::State::Session] Session instance
    def new(blue_prints, driver)
      adapter_composite = self.adapter.build(blue_prints, driver)
      return Session.new(driver: driver, composite: adapter_composite)
    end
  end
end