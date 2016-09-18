require 'ostruct'
require 'colorize'

module AutomationObject
  module Dsl
    class Base < OpenStruct
      # @param [AutomationObject::BluePrint::Composite::] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        ostruct_hash = {}

        #Add attributes the call super
        self.class.has_many_relationships.each { |name, composite_class|
          blue_prints.send(name).each { |child_key, child_blue_prints|
            ostruct_hash[child_key] = composite_class.new(child_blue_prints, state, child_key)
          }
        }

        super ostruct_hash
      end

      # @return [String]
      def inspect(indent = 5)
        string = "#{self.class}"
        self.to_h.each { |key, value|
          case value.class.to_s
            when /Screen/
              string += "\n#{' ' * indent} #{key}:".colorize(:magenta)
            when /Modal/
              string += "\n#{' ' * indent} #{key}:".colorize(:light_magenta)
            when /(Element|ElementHash|ElementArray)/
              string += "\n#{' ' * indent} #{key}:".colorize(:light_blue)
            else
              string += "\n#{' ' * indent} #{key}:".colorize(:red)
          end

          if value.is_a?(Base)
            string += " #{value.inspect(indent + 10)}"
          else
            string += " #{value.inspect}"
          end
        }
        string += ''

        return string
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