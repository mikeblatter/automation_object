require 'ostruct'
require_relative '../../automation_object/helpers/reflection'
module AutomationObject
  module Dsl
    class Base
      include AutomationObject::Reflection

      # @param [AutomationObject::BluePrint::Composite::] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        self.add_children(blue_prints, state)
      end

      def add_children(blue_prints, state)
        self.class.has_many_relationships.each { |name, composite_class|
          blue_prints.send(name).each { |child_key, child_blue_prints|
            self.add_attribute(child_key, composite_class.new(child_blue_prints, state, child_key))
          }
        }
      end

      class << self
        #Has many children relationship for the composite
        # @param children_name [Symbol] name of the children, should be a BluePrint method
        # @param composite_class [Class] interface
        def has_many(children_name, composite_class)
          self.has_many_relationships[children_name] = composite_class
        end

        # @return [Hash] relationships for the composite
        def has_many_relationships
          @has_many_relationships ||= Hash.new
        end
      end
    end
  end
end