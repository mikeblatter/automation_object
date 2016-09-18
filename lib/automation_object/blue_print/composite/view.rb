# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # View composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class View < Base
        # @return [Array<AutomaticOnloadModal>]
        def automatic_onload_modals
          self.adapter.automatic_onload_modals
        end

        # @return [Array<Symbol>]
        def automatic_screen_changes
          self.adapter.automatic_screen_changes
        end

        # @return [Hook]
        def load
          self.adapter.load
        end

        # @return [Hash<Modal>]
        def modals
          self.adapter.modals
        end

        # @return [Hash<Element>]
        def elements
          self.adapter.elements
        end

        # @return [Hash<ElementArray>]
        def element_arrays
          self.adapter.element_arrays
        end

        # @return [Hash<ElementHash>]
        def element_hashes
          self.adapter.element_hashes
        end
      end
    end
  end
end
