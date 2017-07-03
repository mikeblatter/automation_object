# frozen_string_literal: true
# Require parent class
module AutomationObject
  module BluePrint
    module Composite
      # Screen composite class
      module ContainerHelper
        # @return [Array<AutomationObject::BluePrint::Composite::AutomaticModalChange>]
        def automatic_modal_changes
          adapter.automatic_modal_changes
        end

        # @return [Array<Symbol>]
        def automatic_screen_changes
          adapter.automatic_screen_changes
        end

        # @return [AutomationObject::BluePrint::Composite::Hook]
        def load
          adapter.load
        end

        # @return [Hash<AutomationObject::BluePrint::Composite::Element>]
        def elements
          adapter.elements
        end

        # @return [Hash<AutomationObject::BluePrint::Composite::ElementArray>]
        def element_arrays
          adapter.element_arrays
        end

        # @return [Hash<AutomationObject::BluePrint::Composite::ElementHash>]
        def element_hashes
          adapter.element_hashes
        end

        # Get possible changes
        # @return [Array<Symbol>]
        def changes
          changes = []
          elements.merge(element_arrays).merge(element_hashes).each_value { |element|
            changes += element.changes
          }

          changes.uniq.compact
        end

        # @param name [Symbol] name of container you want to go to
        # @return [Symbol, Symbol] name and type of element
        def element_to_container(name)
          elements.merge(element_arrays).merge(element_hashes).each { |element_name, element|
            next unless element.changes.include?(name)

            element_type = nil

            case element
              when Element
                  element_type = :elements
              when ElementArray
                  element_type = :element_arrays
              when ElementHash
                  element_type = :element_hashes
            end

            return element_name, element_type
          }

          return nil, nil
        end
      end
    end
  end
end
