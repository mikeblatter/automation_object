# frozen_string_literal: true

require_relative 'composite/top'
require_relative 'page_object_adapter/top'
require_relative 'page_object_adapter/user_defined'

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

        # Remove any defined classes in UserDefined namespace
        UserDefined.constants.select do |constant|
          UserDefined.const_get(constant).is_a? Class
          UserDefined.remove_const(constant)
        end

        # Add classes defined into UserDefined module
        Dir[File.join(path, '**/*.rb')].each do |file|
          puts file
          puts File.read(file)
          UserDefined.module_eval(File.read(file))
        end

        # Will look for classes defined
        adapter_top = self::Top.new
        AutomationObject::BluePrint::Composite::Top.new(adapter_top)
      end
    end
  end
end
