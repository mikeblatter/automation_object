# frozen_string_literal: true
# Require parent class
require_relative 'base'

require_relative 'automatic_modal_change'
require_relative 'hook'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module BluePrint
    module Composite
      # Modal composite class
      class Modal < Base
        # @return [Array<Symbol>]
        def included_views
          adapter.included_views
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

        # Get possible screen changes
        # @return [Array<Symbol>]
        def screen_changes
          screen_changes = []
          elements.merge(element_arrays).merge(element_hashes).each_value { |element|
            screen_changes += element.screen_changes
          }

          screen_changes.uniq.compact
        end

        # Get possible modal changes
        # @return [Array<Symbol>]
        def modal_changes
          modal_changes = []
          elements.merge(element_arrays).merge(element_hashes).each_value { |element|
            modal_changes += element.modal_changes
          }

          modal_changes.uniq.compact
        end
      end
    end
  end
end
