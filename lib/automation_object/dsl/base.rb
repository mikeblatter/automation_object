require_relative '../proxies/proxy'
require_relative 'models'

module AutomationObject
  module Dsl
    #Base DSL class
    class Base < AutomationObject::Proxies::Proxy
      # @param [AutomationObject::BluePrint::Composite::] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        @blue_prints = blue_prints
        @state = state

        self.class.has_many_relationships.each { |name, composite_class|
          @blue_prints.send(name).each { |child_key, child_blue_prints|
            @subject[child_key] = composite_class.new(blue_prints: child_blue_prints)
          }
        }
      end

      #Has many children relationship for the composite
      # @param children_name [Symbol] name of the children, should be a BluePrint method
      # @param args [Hash] additional arguments, expects interface
      def self.has_many(children_name, args)
        self.has_many_relationships[children_name] = args.fetch(:interface)
      end

      # @return [Hash] relationships for the composite
      def self.has_many_relationships
        @has_many_relationships ||= Hash.new
      end
    end
  end
end