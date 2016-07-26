module AutomationObject
  #Dsl Port
  module Dsl
    extend self

    # @return [AutomationObject::Dsl::Module]
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

      require_relative "dsl/#{adapter_name}"
      @adapter = AutomationObject::Dsl.const_get("#{adapter_const}")
    end

    # Creates/returns composite and attaches the State to the composite
    # @return [AutomationObject::Dsl::Models::Top]
    def new(args={})
      composite = self.adapter.build(args)
      composite.state = args.fetch(:state)

      return composite
    end
  end
end