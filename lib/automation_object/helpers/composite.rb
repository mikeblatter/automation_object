require_relative 'reflection_helper'
require_relative 'composite_hook'

module AutomationObject
  #Composite is a super class that helps build composite objects based of a Hash
  #Composite classes should inherit from this class and use the class-level methods to add the components
  class Composite
    include CompositeHook
    include ReflectionHelper

    attr_accessor :name, :parent, :location

    # @param name [Symbol] name of the object
    # @param parent [Object, nil] parent composite object
    # @param location [String] string location for error/debugging purposes
    def initialize(name = :top, parent = nil, location = 'top')
      self.parent = parent
      self.location = location

      self.before_create_run

      self.add_has_one_relationships
      self.add_has_many_relationships

      self.after_create_run
    end

    # Get top composite Object
    # @return [AutomationObject::Composite]
    def top
      #Should recursively call top until parent is nil
      return (self.parent == nil) ? self : self.parent.top
    end

    # Abstract argument, override
    # @param name [Symbol] name of child
    # @param options [Hash] options for child
    # @return child [Object] return child composite object
    def get_child(name, options)
      raise 'Abstract method'
    end

    # Abstract argument, override
    # @param name [Symbol] name of child
    # @param options [Hash] options for child
    # @return children [Hash] return children and names
    def get_children(name, options)
      raise 'Abstract method'
    end

    def add_has_one_relationships
      self.class.has_one_relationships.each { |name, options|
        self.add_attribute(name, get_child(name, options))
      }
    end

    def add_has_many_relationships
      self.class.has_many_relationships.each { |name, options|
        composite_children = self.create_hash_children(get_children(name, options), options)
        self.add_attribute(name, composite_children)
      }
    end

    # @param children [Hash] hash of children
    # @param args [Hash] arguments for adding children
    def create_hash_children(children, args)
      composite_children = children.inject({}) { |hash, (key, value)|
        child_location = self.location + "[#{key}]"
        hash[key] = args[:interface].new(key, value, self, child_location)
        hash
      }

      return composite_children
    end

    class << self
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

      # @param child_name [Symbol] name of key
      # @param args [Hash] arguments
      def has_one(child_name, args)
        self.has_one_relationships[child_name] = args
      end

      # @return [Hash] hash of relationships
      def has_one_relationships
        @has_one_relationships ||= Hash.new
      end
    end
  end
end