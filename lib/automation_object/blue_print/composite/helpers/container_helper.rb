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
      end
    end
  end
end
