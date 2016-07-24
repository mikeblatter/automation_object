require_relative '../../../../../lib/automation_object/helpers/composite'
require_relative 'validation_helper'

module AutomationObject
  module BluePrint
    module HashAdapter
      class Composite < AutomationObject::Composite
        include ValidationHelper

        attr_accessor :hash

        # @param hash [Hash] hash for the composite to build of off
        # @param name [String] name of composite element
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(hash = {}, name = 'top', parent = nil, location = 'top')
          super(name, parent, location)

          self.hash = (hash.is_a?(Hash)) ? hash : {}
          self.hash.symbolize_keys_deep!

          #Validate using ValidationHelper
          unless self.valid?
            if self.parent
              self.parent.add_errors(self.errors)
            else
              raise Validators::ValidationError.new(self.errors.uniq.reverse)
            end
          end
        end

        # Overriding base get_child method
        # @param name [Symbol] name of child
        # @param options [Hash] options for child
        def get_child(name, options)
          child = (self.hash[options[:key]].is_a?(Hash)) ? self.hash[options[:key]] : Hash.new
          child_location = self.location + "[#{options[:key]}]"

          options[:interface].new(name, child, self, child_location)
        end

        # Overriding base get_children method
        # @param name [Symbol] name of child
        # @param options [Hash] options for child
        # @return children [Hash] return children and names
        def get_children(name, options)
          children = self.hash[options[:key]]
          (children.is_a?(Hash)) ? children : Hash.new
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
      end
    end
  end
end