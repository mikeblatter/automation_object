require_relative '../../helpers/composite'
require_relative 'top'
require_relative 'screen'

module AutomationObject
  module State
    module BluePrintAdapter
      #Parent composite class
      class Composite < Composite
        attr_accessor :blue_prints, :driver

        def children
          @children ||= Hash.new
        end

        # @param hash [Hash] hash for the composite to build of off
        # @param name [Symbol] name of composite element
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(hash = {}, name = :top, parent = nil, location = 'top')
          #Add hash before calling super
          self.hash = (hash.is_a?(Hash)) ? hash : {}
          self.hash.symbolize_keys_deep!

          super(name, parent, location)

          #Validate using ValidationHelper
          unless self.valid?
            if self.parent
              self.parent.add_errors(self.errors)
            else
              raise Validators::ValidationError.new(self.errors.uniq.reverse)
            end
          end
        end




        def initialize(args={})
          self.blue_prints = args.fetch :blue_prints
          self.driver = args.fetch :driver

          self.name = args.fetch :name, nil
          self.parent = args.fetch :parent, nil

          #Build composite on self, using children property.
          self.build_composite
        end

        # Recursive function to reach top with ease
        # @return [AutomationObject::State::BluePrintAdapter::Top]
        def top
          #Should recursively call top until parent is nil
          return (self.parent == nil) ? self : self.parent.top
        end

        # Recursive function to reach parent screen
        # @return [AutomationObject::State::BluePrintAdapter::Screen,nil]
        def screen
          return nil if self.is_a?(Top)

          #Should recursively call top until parent is nil
          return (self.is_a?(Screen)) ? self : self.parent.screen
        end

        def build_composite
          self.add_has_one_relationships
          self.add_has_many_relationships
        end

        def add_has_one_relationships
          self.class.has_one_relationships.each { |name, composite_class|
            self.children[name] = composite_class.new(name: name,
                                                      blue_prints: self.blue_prints.send(name),
                                                      driver: self.driver,
                                                      parent: self)
            self.add_attribute(name, self.children[name])
          }
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