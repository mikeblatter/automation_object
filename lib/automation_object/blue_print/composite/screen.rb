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
        # @return [Array<AutomaticModalChange>]
        def automatic_modal_changes
          adapter.automatic_modal_changes
        end

        # @return [Array<Symbol>]
        def automatic_screen_changes
          adapter.automatic_screen_changes
        end

        # @return [Hook]
        def accept
          adapter.accept
        end

        # @return [Hook]
        def dismiss
          adapter.dismiss
        end

        # @return [Hook]
        def load
          adapter.load
        end

        # @return [Hash<Modal>]
        def modals
          adapter.modals
        end

        # @return [Hash<Element>]
        def elements
          adapter.elements
        end

        # @return [Hash<ElementArray>]
        def element_arrays
          adapter.element_arrays
        end

        # @return [Hash<ElementHash>]
        def element_hashes
          adapter.element_hashes
        end
      end
    end
  end
end
