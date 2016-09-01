require_relative '../../helpers/composite'
require_relative 'top'
require_relative 'screen'

module AutomationObject
  module State
    module Composite
      #Parent composite class
      class Base < AutomationObject::Composite
        # @return [AutomationObject::State::Session]
        attr_accessor :state

        # @return [AutomationObject::BluePrint::Composite::]
        attr_accessor :blue_prints

        # @return [AutomationObject::Driver::Driver]
        attr_accessor :driver

        # @param state [AutomationObject::State::Session] session
        # @param blue_prints [AutomationObject::BluePrint::Composite] blue print composite
        # @param driver [AutomationObject::Driver] driver
        # @param name [Symbol] name of composite element
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(state, blue_prints, driver, name = :top, parent = nil, location = 'top')
          self.state = state
          self.blue_prints = blue_prints
          self.driver = driver

          super(name, parent, location)
        end

        # Overriding base get_child method
        # @param name [Symbol] name of child
        # @param args [Hash] args
        def get_child(name, args)
          child_location = self.location + "[#{name}]"

          return args.fetch(:interface).new(self.blue_prints.send(name), self.driver, name, self, child_location)
        end

        # Overriding base get_children method
        # @param name [Symbol] name of child
        # @param args [Hash] args
        # @return children [Array<Composite>] return children and names
        def get_children(name, args)
          children_hash = Hash.new

          self.blue_prints.send(name).each { |child_key, child_blue_prints|
            child_location = self.location + "[#{child_key}]"

            children_hash[child_key] = args.fetch(:interface).new(child_blue_prints,
                                                                  self.driver,
                                                                  name,
                                                                  self,
                                                                  child_location)
          }

          return children_hash
        end

        # Recursive function to reach parent screen
        # Can return nil if above a screen!
        # @return [AutomationObject::State::BluePrintAdapter::Screen,nil]
        def screen
          return nil if self.is_a?(Top)

          #Should recursively call top until parent is nil
          return (self.is_a?(Screen)) ? self : self.parent.screen
        end
      end
    end
  end
end