require_relative '../../helpers/composite'
require_relative 'top'
require_relative 'screen'

module AutomationObject
  module State
    module BluePrintAdapter
      #Parent composite class
      class NewComposite < AutomationObject::Composite
        attr_accessor :blue_prints, :driver

        # @param blue_prints [AutomationObject::BluePrint::Composite] blue print composite
        # @param driver [AutomationObject::Driver] driver
        # @param name [Symbol] name of composite element
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(blue_prints, driver, name = :top, parent = nil, location = 'top')
          self.blue_prints = blue_prints
          self.driver = driver

          super(name, parent, location)
        end

        # Overriding base get_child method
        # @param name [Symbol] name of child
        # @param composite_class [Class] composite class to create
        def get_child(name, composite_class)
          child_location = self.location + "[#{name}]"

          return composite_class.new(self.blue_prints.send(name), self.driver, name, self, child_location)
        end

        # Overriding base get_children method
        # @param name [Symbol] name of child
        # @param options [Hash] options for child
        # @return children [Array<Composite>] return children and names
        def get_children(name, options)
          children_hash = Hash.new

          self.blue_prints.send(name).each { |child_key, child_blue_prints|
            children_hash[child_key]

          }
        end

        # Recursive function to reach parent screen
        # Can return nil if above a screen!
        # @return [AutomationObject::State::BluePrintAdapter::Screen,nil]
        def screen
          return nil if self.is_a?(Top)

          #Should recursively call top until parent is nil
          return (self.is_a?(Screen)) ? self : self.parent.screen
        end

        def add_has_many_relationships
          self.class.has_many_relationships.each { |name, composite_class|
            children_hash = Hash.new

            self.blue_prints.send(name).each { |child_key, child_blue_prints|
              children_hash[child_key] = composite_class.new(name: child_key,
                                                             blue_prints: child_blue_prints,
                                                             driver: self.driver,
                                                             parent: self)
              children_hash[child_key].build_composite

              self.children[child_key] = children_hash[child_key]
            }

            self.add_attribute(name, children_hash)
          }
        end
      end
    end
  end
end