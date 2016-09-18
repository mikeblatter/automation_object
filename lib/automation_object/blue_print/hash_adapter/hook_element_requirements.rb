# Require parent class
require_relative 'composite'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Hook Element Requirements-level composite
      class HookElementRequirements < Composite
        # Valdiations
        validates :element_name, presence_of: true, instance_of: [String, Symbol], element_presence_of: true
        validates :exists?, presence_of: true, instance_of: [FalseClass, TrueClass]

        # Get the order to run the hook in
        # @return [Array<Symbol>] list of hook methods to run in given order
        def hook_order
          hook_order = [:exists?] # Always put exists? first

          self.hash.keys.each { |hook_name|
            hook_order.push(hook_name) unless [:element_name, :exists?].include?(hook_name)
          }

          return hook_order
        end

        # Get element requirement
        # @param name [Symbol] name of requested requirement
        def requirement(name)
          return self.hash[name] ||= nil
        end

        # Get name of the element
        # @return [Symbol] name of element
        def element_name
          element_name = self.hash[:element_name]

          case element_name
            when Symbol, String
              return element_name.to_sym
            else
              return nil
          end
        end

        # Convience for getting element blueprints
        # @return [AutomationObject::BluePrint::HashAdapter::Element]
        def element_blueprints(composite_object = nil)
          unless composite_object
            composite_object = self
          end

          # Traverse!
          if composite_object.hash[:elements].is_a?(Hash)

            return composite_object.elements[self.element_name]
          elsif composite_object.parent
            return self.element_blueprints(composite_object.parent)
          end

          return nil
        end
      end
    end
  end
end
