# frozen_string_literal: true

require_relative 'composite'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # HookElementRequirements composite
      class HookElementRequirements < Composite
        # Get the order to run the hook in
        # @return [Array<Symbol>] list of hook methods to run in given order
        def hook_order
          hook_order = [:exists?] # Always put exists? first

          hash.each_key do |hook_name|
            hook_order.push(hook_name) unless %i[element_name exists?].include?(hook_name)
          end

          hook_order
        end

        # Get element requirement
        # @param name [Symbol] name of requested requirement
        def requirement(name)
          hash[name] ||= nil
        end

        # Get name of the element
        # @return [Symbol] name of element
        def element_name
          element_name = hash[:element_name]

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
          composite_object ||= self

          # Traverse!
          return composite_object.elements[element_name] if composite_object.hash[:elements].is_a?(Hash)

          return element_blueprints(composite_object.parent) if composite_object.parent

          nil
        end
      end
    end
  end
end
