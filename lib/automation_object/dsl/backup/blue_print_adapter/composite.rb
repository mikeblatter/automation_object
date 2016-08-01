module AutomationObject
  module Dsl
    module BluePrintAdapter
      #Base class for the DSL BluePrint adapter composite
      #BluePrintAdapter uses the BluePrint composite to create the proxy/model composite in the DSL
      class Composite
        class << self;
          attr_accessor :implemented_proxy
        end

        # @param args [Hash] arguments, expects :blue_prints
        def initialize(args={})
          @blue_prints = args.fetch :blue_prints
        end

        # Build and return the DSL composite
        # @return [Object] composite for the given level
        def build
          proxy = self.class.implemented_proxy.new

          self.class.has_many_relationships.each { |name, composite_class|
            @blue_prints.send(name).each { |child_key, child_blue_prints|
              child_composite = composite_class.new(blue_prints: child_blue_prints)
              child_proxy = child_composite.build

              type = name.to_s.gsub(/e?s$/, '').to_sym #Unpluralize
              proxy.add(name: child_key, type: type, object: child_proxy)
            }
          }

          return proxy
        end

        #Declare which proxy is being used by the given BluePrint::Adapter composite class
        # @param proxy_class [Class] proxy class used by the given composite
        def self.implements_proxy(proxy_class)
          self.implemented_proxy = proxy_class
        end

        #Has many children relationship for the composite
        # @param children_name [Symbol] name of the children, should be a BluePrint method
        # @param args [Hash] additional arguments, expects interface
        def self.has_many(children_name, args)
          self.has_many_relationships[children_name] = args.fetch(:interface)
        end

        # @return [Hash] relationships for the composite
        def self.has_many_relationships
          @has_many_relationships ||= Hash.new
        end
      end
    end
  end
end