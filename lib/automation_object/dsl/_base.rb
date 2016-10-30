# frozen_string_literal: true

module AutomationObject
  module Dsl
    # Base DSL Object
    class Base < OpenStruct
      # @param [AutomationObject::BluePrint::Composite::] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        ostruct_hash = {}

        # Add attributes the call super
        self.class.has_many_relationships.each do |name, composite_class|
          blue_prints.send(name).each do |child_key, child_blue_prints|
            ostruct_hash[child_key] = composite_class.new(child_blue_prints, state, child_key)
          end
        end

        super ostruct_hash
      end

      # @param _indent [Integer]
      # @return [String]
      def inspect(_indent = 5)
        string = self.class.to_s

        to_h.each do |key, value|
          string += formatted_name(key, _indent)
          string += sub_inspect(value, _indent)
        end

        string
      end

      # @param key [String]
      # @param indent [Integer]
      # @return [String]
      def formatted_name(key, indent)
        color = (self[key].alive?) ? :green : :blue
        "\n#{' ' * indent} #{key}:".colorize(color)
      end

      # @param value [Object]
      # @param indent [Integer]
      # @return [String]
      def sub_inspect(value, indent)
        if value.is_a?(Base)
          " #{value.inspect(indent + 10)}"
        else
          " #{value.inspect}"
        end
      end

      class << self
        # Has many children relationship for the composite
        # @param children_name [Symbol] name of the children, should be a BluePrint method
        # @param composite_class [Class] interface
        def has_many(children_name, composite_class)
          has_many_relationships[children_name] = composite_class
        end

        # @return [Hash] relationships for the composite
        def has_many_relationships
          @has_many_relationships ||= {}
        end
      end
    end
  end
end
