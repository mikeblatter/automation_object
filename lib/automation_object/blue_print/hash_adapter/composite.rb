require_relative '../../helpers/reflection_helper'
require_relative 'helpers/validation_helper'
require_relative 'helpers/hook_helper'

require_relative 'validators/validation_error'

module AutomationObject
  module BluePrint
    module HashAdapter
      #Composite is a super class that helps build composite objects based of a Hash
      #Composite classes should inherit from this class and use the class-level methods to add the components
      class Composite
        include AutomationObject::ReflectionHelper
        include ValidationHelper
        include HookHelper

        attr_accessor :hash, :parent, :location

        # @param hash [Hash] hash for the composite to build of off
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(hash = {}, parent = nil, location = 'top')
          self.hash = (hash.is_a?(Hash)) ? hash : {}
          self.hash.symbolize_keys_deep!

          self.parent = parent
          self.location = location

          self.before_create_run

          self.add_has_many_relationships
          self.add_has_one_relationships

          #Validate using ValidationHelper
          unless self.valid?
            if self.parent
              self.parent.add_errors(self.errors)
            else
              raise Validators::ValidationError.new(self.errors.reverse)
            end
          end

          self.after_create_run
        end

        # @param name [Symbol] name of key
        # @param args [Hash] arguments
        def self.has_many(name, args)
          key = args.fetch :key, name
          interface = args.fetch :interface

          self.has_many_relationships[name] = {
              :key => key,
              :interface => interface
          }
        end

        # @return [Hash] hash of relationships
        def self.has_many_relationships
          @has_many_relationships ||= Hash.new
        end

        def add_has_many_relationships
          self.class.has_many_relationships.each { |name, options|
            children = self.hash[options[:key]]

            children = (children.is_a?(Hash)) ? children : Hash.new
            composite_children = self.create_hash_children(children, options)

            self.add_attribute(name, composite_children)
          }
        end

        # @param children [Hash] hash of children
        # @param args [Hash] arguments for adding children
        def create_hash_children(children, args)
          composite_children = children.inject({}) { |hash, (key, value)|
            child_location = self.location + "[#{key}]"
            hash[key] = args[:interface].new(value, self, child_location)
            hash
          }

          return composite_children
        end

        # @param children [Array] hash of children
        # @param args [Hash] arguments for adding children
        def create_array_children(children, args)
          composite_children = children.map.with_index { |child, index|
            location = (args[:location]) ? args[:location] : self.location
            child_location = location + "[#{index}]"
            args[:interface].new(child, self, child_location)
          }

          return composite_children
        end

        # @param name [Symbol] name of key
        # @param args [Hash] arguments
        def self.has_one(name, args)
          key = args.fetch :key, name
          interface = args.fetch :interface

          self.has_one_relationships[name] = {
              :key => key,
              :interface => interface
          }
        end

        # @return [Hash] hash of relationships
        def self.has_one_relationships
          @has_one_relationships ||= Hash.new
        end

        def add_has_one_relationships
          self.class.has_one_relationships.each { |name, options|
            child = (self.hash[options[:key]].is_a?(Hash)) ? self.hash[options[:key]] : Hash.new
            child_location = self.location + "[#{options[:key]}]"
            composite_child = options[:interface].new(child, self, child_location)
            self.add_attribute(name, composite_child)
          }
        end
      end
    end
  end
end