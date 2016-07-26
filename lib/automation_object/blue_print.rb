module AutomationObject
  #BluePrint Port, encapsulation of code required to parse and build composite data structure representing UI
  #Provides for loading Hash/YAML, validates the resulting structure (throws errors), and a common
  #interface for the rest of the code base to use.
  module BluePrint
    extend self

    # Get method for BluePrint adapter const for composite BluePrint build
    # Each adapter will implement common BluePrint interface
    # @return [AutomationObject::BluePrint::Module] returns adapter const for composite blue print build
    def adapter
      return @adapter if @adapter
      self.adapter = :hash
      @adapter
    end

    # Sets adapter const will append _adapter if needed
    # @param adapter_name [String] name of adapter wanted for composite creation
    def adapter=(adapter_name)
      adapter_name = adapter_name.to_s
      adapter_name << '_adapter' unless adapter_name.match(/_adapter$/)
      adapter_const = adapter_name.pascalize

      require_relative "blue_print/#{adapter_name}"
      @adapter = AutomationObject::BluePrint.const_get("#{adapter_const}")
    end

    def new(blueprint_arg)
      case blueprint_arg
        when String
          self.adapter = :yaml
        when Hash
          self.adapter = :hash
      end

      adapter.build(blueprint_arg)
    end
  end
end