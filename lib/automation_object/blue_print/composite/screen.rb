# frozen_string_literal: true
# Require parent class
require_relative 'base'

require_relative 'automatic_modal_change'
require_relative 'hook'

require_relative 'modal'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module BluePrint
    module Composite
      # Screen composite class
      class Screen < Base
        # @return [Array<AutomationObject::BluePrint::Composite::AutomaticModalChange>]
        def automatic_modal_changes
          adapter.automatic_modal_changes
        end

        # @return [Array<Symbol>]
        def automatic_screen_changes
          adapter.automatic_screen_changes
        end

        # @return [AutomationObject::BluePrint::Composite::Hook]
        def accept
          adapter.accept
        end

        # @return [AutomationObject::BluePrint::Composite::Hook]
        def dismiss
          adapter.dismiss
        end

        # @return [AutomationObject::BluePrint::Composite::Hook]
        def load
          adapter.load
        end

        # @return [Hash<AutomationObject::BluePrint::Composite::Modal>]
        def modals
          adapter.modals
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
