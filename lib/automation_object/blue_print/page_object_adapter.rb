# frozen_string_literal: true
require 'securerandom'

require_relative 'composite/top'
require_relative 'page_object_adapter/top'

require_relative '../page_object'

# PageObject adapter
module AutomationObject
  module BluePrint
    # BluePrint PageObject Adapter
    # Using classes to define page objects
    module PageObjectAdapter
      module_function

      # @param path [String] path to PageObject classes
      # @return [AutomationObject::BluePrint::Composite::Top] Composite BluePrint Object
      def build(path = '')
        # Require ruby files in that path into a module namespace
        path = File.expand_path(path)
        random_module_name = [*('A'..'Z')].sample(20).join
        random_module_symbol = random_module_name.to_sym

        AutomationObject::BluePrint::PageObjectAdapter.module_eval %Q?
          module #{random_module_name}

          end
        ?

        defined_module = const_get(random_module_symbol)

        # Remove any defined classes in UserDefined namespace
        defined_module.constants.select do |constant|
          defined_module.const_get(constant).is_a? Class
          defined_module.remove_const(constant)
        end

        # Add classes defined into UserDefined module
        Dir[File.join(path, '**/*.rb')].each do |file|
          defined_module.module_eval(File.read(file))
        end

        # Will look for classes defined
        adapter_top = self::Top.new(defined_module)
        AutomationObject::BluePrint::Composite::Top.new(adapter_top)
      end
    end
  end
end
