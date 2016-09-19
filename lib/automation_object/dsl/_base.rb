# frozen_string_literal: true
require 'ostruct'
require 'colorize'

module AutomationObject
  module Dsl
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

      # @return [String]
      def inspect(indent = 5)
        string = self.class.to_s
        to_h.each do |key, value|
          string += case value.class.to_s
                    when /Screen/
                      "\n#{' ' * indent} #{key}:".colorize(:magenta)
                    when /Modal/
                      "\n#{' ' * indent} #{key}:".colorize(:light_magenta)
                    when /(Element|ElementHash|ElementArray)/
                      "\n#{' ' * indent} #{key}:".colorize(:light_blue)
                    else
                      "\n#{' ' * indent} #{key}:".colorize(:red)
                    end

          string += if value.is_a?(Base)
                      " #{value.inspect(indent + 10)}"
                    else
                      " #{value.inspect}"
                    end
        end
        string += ''

        string
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
