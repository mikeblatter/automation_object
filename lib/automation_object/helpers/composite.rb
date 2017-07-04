# frozen_string_literal: true

require_relative 'reflection'
require_relative 'composite_hook'

module AutomationObject
  # Composite is a super class that helps build composite objects based of a Hash
  # Composite classes should inherit from this class and use the class-level methods to add the components
  class Composite
    include CompositeHook
    include Reflection

    attr_accessor :name, :parent, :location, :children

    # @param name [Symbol] name of the object
    # @param parent [Object, nil] parent composite object
    # @param location [String] string location for error/debugging purposes
    def initialize(name = :top, parent = nil, location = 'top')
      self.name = name
      self.parent = parent
      self.location = location

      before_create_run

      add_has_one_relationships
      add_has_many_relationships

      after_create_run
    end

    # Remove getter to solve stupid Ruby warning
    undef :children if method_defined? :children
    def children
      @children ||= {}
    end

    # Get top composite Object
    # @return [AutomationObject::Composite]
    def top
      # Should recursively call top until parent is nil
      parent.nil? ? self : parent.top
    end

    # Abstract argument, override
    # @param _name [Symbol] name of child
    # @param _options [Hash] options for child
    # @return child [Object] return child composite object
    def get_child(_name, _options)
      raise 'Abstract method'
    end

    # Abstract argument, override
    # @param _name [Symbol] name of child
    # @param _options [Hash] options for child
    # @return children [Hash] return children and names
    def get_children(_name, _options)
      raise 'Abstract method'
    end

    def add_has_one_relationships
      self.class.has_one_relationships.each do |name, options|
        children[name] = get_child(name, options)
        add_attribute(name, children[name])
      end
    end

    def add_has_many_relationships
      self.class.has_many_relationships.each do |name, options|
        composite_children = get_children(name, options)
        children[name] = composite_children
        add_attribute(name, children[name])
      end
    end

    class << self
      # Has many children relationship for the composite
      # @param children_name [Symbol] name of the children, should be a BluePrint method
      # @param args [Hash] additional arguments, expects interface
      def has_many(children_name, args)
        has_many_relationships[children_name] = args
      end

      # @return [Hash] relationships for the composite
      def has_many_relationships
        @has_many_relationships ||= {}
      end

      # @param child_name [Symbol] name of key
      # @param args [Hash] arguments
      def has_one(child_name, args)
        has_one_relationships[child_name] = args
      end

      # @return [Hash] hash of relationships
      def has_one_relationships
        @has_one_relationships ||= {}
      end
    end
  end
end
