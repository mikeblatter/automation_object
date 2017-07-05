# frozen_string_literal: true

require_relative '../../helpers/composite'
require_relative '../../helpers/string'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Base composite for PageObject adapter
      class Composite < AutomationObject::Composite
        # @return [Module]
        attr_accessor :user_defined_module

        # @return [Class]
        attr_accessor :constant

        # @param user_defined_module [Module] runtime defined module for loaded page objects
        # @param constant [Class] class to build composite off of
        # @param name [Symbol] name of composite element
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(user_defined_module, constant = nil, name = :top, parent = nil, location = 'top')
          self.user_defined_module = user_defined_module
          self.constant = constant.is_a?(Class) ? constant : nil

          super(name, parent, location)
        end

        # Get child of composite
        # @param name [Symbol] name of child
        # @param options [Hash] options for child
        # @return child [Object] return child composite object
        def get_child(name, options)
          child = hash[name].is_a?(Hash) ? hash[name] : {}
          child_location = location + "[#{name}]"

          create_composite(options, child, name, child_location)
        end

        # Get children of composite
        # @param name [Symbol] name of child
        # @param options [Hash] options for child
        # @return [Hash] return children and names
        def get_children(name, options)
          new_children = {}

          self.constant.constants.each { |constant_symbol|
            constant = self.constant.const_get(constant_symbol)
            # Check to see if constant is a child class of the public PageObject interface
            next unless constant < options[:public_interface]

            name = constant.name.split('::').last.to_underscore.to_sym
            new_children[name] = create_composite(constant, options[:interface], name)
          }

          new_children
        end

        def create_composite(constant, interface, name)
          # Get the Composite Class that corresponds with the PageObjectAdapter Class
          class_name = interface.name.split('::').last
          child_location = location + "[#{name}]"

          require_relative "../composite/#{class_name.to_underscore}"
          composite_class = AutomationObject::BluePrint::Composite.const_get(class_name)

          composite_class.new(interface.new(user_defined_module, constant, name, self, child_location))
        end

        def get_property(name)
          self.constant.send(name)
        end
      end
    end
  end
end
