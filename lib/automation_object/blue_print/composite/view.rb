# frozen_string_literal: true
# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # View composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class View < Base
        # @return [Hook]
        def load
          adapter.load
        end

        # @return [Hook]
        def accept
          adapter.accept
        end

        # @return [Hook]
        def dismiss
          adapter.dismiss
        end

        # @return [Array<AutomaticModalChange>]
        def automatic_modal_changes
          adapter.automatic_modal_changes
        end

        # @return [Array<Symbol>]
        def automatic_screen_changes
          adapter.automatic_screen_changes
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
