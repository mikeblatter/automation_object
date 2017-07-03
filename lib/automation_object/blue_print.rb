# frozen_string_literal: true

require_relative 'blue_print/hash_adapter'
require_relative 'blue_print/yaml_adapter'
require_relative 'blue_print/page_object_adapter'

module AutomationObject
  # BluePrint Port, encapsulation of code required to parse and build composite data structure representing UI
  # Provides for loading Hash/YAML, validates the resulting structure (throws errors), and a common
  # interface for the rest of the code base to use.
  module BluePrint
    module_function

    # Get method for BluePrint adapter const for composite BluePrint build
    # Each adapter will implement common BluePrint interface
    # @return [AutomationObject::BluePrint::YamlAdapter, AutomationObject::BluePrint::HashAdapter, AutomationObject::BluePrint::PageObjectAdapter]
    def adapter
      return @adapter if @adapter
      self.adapter = :hash
      @adapter
    end

    # Sets adapter const will append _adapter if needed
    # @param adapter_name [String] name of adapter wanted for composite creation
    def adapter=(adapter_name)
      adapter_name = adapter_name.to_s
      adapter_name << '_adapter' unless adapter_name =~ /_adapter$/
      adapter_const = adapter_name.pascalize

      @adapter = AutomationObject::BluePrint.const_get(adapter_const.to_s)
    end

    # Adapters use the composite AutomationObject::BluePrint::Composite interfaces
    # @return [AutomationObject::BluePrint::Composite::Top]
    def create(blueprint_arg)
      case blueprint_arg
      when String
        path = File.expand_path(blueprint_arg)

        self.adapter = if !Dir[File.join(path, '/**/*.rb')].empty?
                         :page_object
                       else
                         :yaml
                       end
      when Hash
        self.adapter = :hash
      end

      adapter.build(blueprint_arg)
    end
  end
end
