# frozen_string_literal: true
require 'securerandom'

require_relative 'composite/top'
require_relative 'page_object_adapter/top'

require_relative '../page_object'

# PageObject Adapter
module AutomationObject
  module BluePrint
    # BluePrint PageObject Adapter
    # Using classes to define screens vs hashes/YAML
    # Think will be easier for IDE to process
    # as well as provide custom callback methods for interacting with UI/etc...
    module PageObjectAdapter
      module_function

      # @param path [String] path to PageObject classes
      # @return [AutomationObject::BluePrint::Composite::Top] Composite BluePrint Object
      def build(path)
        # Require ruby files in that path into a module namespace
        path = File.expand_path(path)

        defined_module = define_random_module

        # Remove any defined classes in UserDefined namespace
        defined_module.constants.select do |constant|
          defined_module.const_get(constant).is_a? Class
          defined_module.remove_const(constant)
        end

        # Add classes defined into UserDefined module
        if Dir.exist?(path)
          Dir[File.join(path, '**/*.rb')].each do |file|
            defined_module.module_eval(File.read(file))
          end
        else
          raise ArgumentError.new('Expecting path to exist')
        end

        # Will look for classes defined
        adapter_top = self::Top.new(defined_module)
        AutomationObject::BluePrint::Composite::Top.new(adapter_top)
      end

      # adding a wrapper for classes added, so they can be redefined elsewhere
      # internal for page object
      def define_random_module
        random_module_name = [*('A'..'Z')].sample(20).join
        random_module_symbol = random_module_name.to_sym

        AutomationObject::BluePrint::PageObjectAdapter.module_eval %Q?
          module #{random_module_name}

          end
        ?

        const_get(random_module_symbol)
      end
    end
  end
end
