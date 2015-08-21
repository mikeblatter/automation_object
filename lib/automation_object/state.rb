require_relative 'state/controller'

module AutomationObject
  #State Port, following port/adapter pattern
  #BluePrintAdapter adapts the state to the blueprint
  module State
    extend self

    # @return [AutomationObject::State::Module]
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

    # Creates/returns the controller, attaches driver, and composite adapter
    # @param args [Hash] arguments
    # @return [AutomationObject::State::Controller] state controller
    def new(args={})
      adapter_composite = self.adapter.build_composite(args)
      return Controller.new(driver: args.fetch(:driver), composite: adapter_composite)
    end
  end
end