require_relative '../proxies/proxy'
require_relative '../helpers/string'

require_relative 'error'
require_relative 'models'

module AutomationObject
  module Dsl
    #Base DSL class
    class Base < AutomationObject::Proxies::Proxy
      # @param [AutomationObject::BluePrint::Composite::] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [AutomationOBject::Dsl::Model::] subject
      def initialize(blue_prints, state, subject)
        @blue_prints = blue_prints
        @state = state

        @subject = subject

        @children = []

        self.has_many_relationships.each { |name, composite_class|
          @blue_prints.send(name).each { |child_key, child_blue_prints|
            @subject[child_key] = composite_class.new(child_blue_prints, @state)
            @children.push(child_key)
          }
        }
      end

      def method_missing(method_symbol, *args, &block)
        if @subject[method_symbol]
          type = @subject[method_symbol].class.name.split('::').last.to_underscore.to_sym
          @state.load(type, method_symbol)
        end

        @subject.send(method_symbol, *args, &block)
      end

      protected

      #Has many children relationship for the composite
      # @param children_name [Symbol] name of the children, should be a BluePrint method
      # @param args [Hash] additional arguments, expects interface
      def has_many(children_name, args)
        self.has_many_relationships[children_name] = args
      end

      # @return [Hash] relationships for the composite
      def has_many_relationships
        @has_many_relationships ||= Hash.new
      end
    end
  end
end