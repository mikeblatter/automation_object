require_relative '../../helpers/reflection_helper'

module AutomationObject
  module State
    module BluePrintAdapter
      #Parent composite class
      class Composite
        include AutomationObject::ReflectionHelper

        attr_accessor :blue_prints, :children, :session, :parent

        def children
          @children ||= Hash.new
        end

        def session=(session_object)
          @session = session_object
          self.children.each_value { |child|
            child.session = session_object
          }
        end

        def initialize(args={})
          self.blue_prints = args.fetch(:blue_prints)
          self.parent = args.fetch :parent, nil

          #Build composite on self, using children property.
          self.build_composite
        end

        def build_composite
          self.add_has_one_relationships
          self.add_has_many_relationships
        end

        def add_has_one_relationships
          self.class.has_one_relationships.each { |name, composite_class|
            self.children[name] = composite_class.new(blue_prints: self.blue_prints.send(name), parent: self)
            self.add_attribute(name, self.children[name])
          }
        end

        def add_has_many_relationships
          self.class.has_many_relationships.each { |name, composite_class|
            children_hash = Hash.new

            self.blue_prints.send(name).each { |child_key, child_blue_prints|
              children_hash[child_key] = composite_class.new(blue_prints: child_blue_prints, parent: self)
              children_hash[child_key].build_composite

              self.children[child_key] = children_hash[child_key]
            }

            self.add_attribute(name, children_hash)
          }
        end

        class << self
          #Has many children relationship for the composite
          # @param children_name [Symbol] name of the children, should be a BluePrint method
          # @param args [Hash] additional arguments, expects interface
          def has_many(children_name, args)
            self.has_many_relationships[children_name] = args.fetch(:interface)
          end

          # @return [Hash] relationships for the composite
          def has_many_relationships
            @has_many_relationships ||= Hash.new
          end

          # @param child_name [Symbol] name of key
          # @param args [Hash] arguments
          def has_one(child_name, args)
            self.has_one_relationships[child_name] = args.fetch(:interface)
          end

          # @return [Hash] hash of relationships
          def has_one_relationships
            @has_one_relationships ||= Hash.new
          end
        end
      end
    end
  end
end