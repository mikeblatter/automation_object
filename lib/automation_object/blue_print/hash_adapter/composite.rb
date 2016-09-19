# frozen_string_literal: true
require_relative '../../helpers/composite'
require_relative '../../helpers/string'

require_relative 'helpers/validation_helper'
require_relative 'helpers/validation_error'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Base composite for blue print hash adapter
      class Composite < AutomationObject::Composite
        include ValidationHelper

        attr_accessor :hash

        # @param hash [Hash] hash for the composite to build of off
        # @param name [Symbol] name of composite element
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(hash = {}, name = :top, parent = nil, location = 'top')
          # Add hash before calling super
          self.hash = hash.is_a?(Hash) ? hash : {}
          self.hash.symbolize_keys_deep!

          super(name, parent, location)

          # Validate using ValidationHelper
          return if valid?

          if self.parent
            self.parent.add_errors(errors)
          else
            raise ValidationError, errors.uniq.reverse
          end
        end

        # Overriding base get_child method
        # @param name [Symbol] name of child
        # @param options [Hash] options for child
        def get_child(name, options)
          child = hash[name].is_a?(Hash) ? hash[name] : {}
          child_location = location + "[#{name}]"

          create_composite(options, child, name, child_location)
        end

        # Overriding base get_children method
        # @param name [Symbol] name of child
        # @param options [Hash] options for child
        # @return children [Hash] return children and names
        def get_children(name, options)
          children = hash[name]
          children = children.is_a?(Hash) ? children : {}

          create_hash_children(children, options)
        end

        # @param name [Symbol] name of child
        # @param children [Array] hash of children
        # @param args [Hash] arguments for adding children
        def create_array_children(name, children, args)
          composite_children = children.map.with_index do |child, index|
            location = args[:location] ? args[:location] : self.location
            child_location = location + "[#{index}]"

            create_composite(args, child, "#{name}[#{index}]", child_location)
          end

          composite_children
        end

        # @param children [Hash] hash of children
        # @param args [Hash] arguments for adding children
        def create_hash_children(children, args)
          composite_children = children.each_with_object({}) do |(key, value), hash|
            child_location = location + "[#{key}]"

            hash[key] = create_composite(args, value, key, child_location)
            hash
          end

          composite_children
        end

        def create_composite(args, child, name, location)
          # Get the Composite Class that corresponds with the HashAdapter Class
          class_name = args[:interface].name.split('::').last

          require_relative "../composite/#{class_name.to_underscore}"
          composite_class = AutomationObject::BluePrint::Composite.const_get(class_name)

          composite_class.new(args[:interface].new(child, name, self, location))
        end
      end
    end
  end
end
