# frozen_string_literal: true

require_relative '../helpers/composite'

module AutomationObject
  module State
    # Parent composite class
    class Base < ::AutomationObject::Composite
      # @return [AutomationObject::Driver::Driver]
      attr_accessor :driver

      # @return [AutomationObject::BluePrint::Composite::Base]
      attr_accessor :blue_prints

      # @param driver [AutomationObject::Driver] driver
      # @param blue_prints [AutomationObject::BluePrint::Composite::Base] blue print composite
      # @param name [Symbol] name of composite element
      # @param parent [Object, nil] parent composite object
      # @param location [String] string location for error/debugging purposes
      def initialize(driver, blue_prints, name = :top, parent = nil, location = 'top')
        self.driver = driver
        self.blue_prints = blue_prints

        super(name, parent, location)
      end

      # Overriding base get_child method
      # @param name [Symbol] name of child
      # @param args [Hash] args
      def get_child(name, args)
        child_location = location + "[#{name}]"

        args.fetch(:interface).new(driver,
                                   blue_prints.send(name),
                                   name, self, child_location)
      end

      # Overriding base get_children method
      # @param name [Symbol] name of child
      # @param args [Hash] args
      # @return children [Array<Composite>] return children and names
      def get_children(name, args)
        children_hash = {}

        blue_prints.send(name).each do |child_key, child_blue_prints|
          child_location = location + "[#{child_key}]"

          children_hash[child_key] = args.fetch(:interface).new(driver,
                                                                child_blue_prints,
                                                                child_key, self, child_location)
        end

        children_hash
      end

      # Recursive function to reach parent screen
      # Can return nil if above a screen!
      # @return [AutomationObject::State::Screen,nil]
      def screen
        return nil if is_a?(Top)

        # Should recursively call top until parent is nil
        is_a?(Screen) ? self : parent.screen
      end

      # Recursive function to reach top
      # @return [AutomationObject::State::Top]
      def top
        is_a?(Top) ? self : parent.top
      end
    end
  end
end
