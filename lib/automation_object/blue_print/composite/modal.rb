#Require parent class
require_relative 'base'

require_relative 'automatic_onload_modal'
require_relative 'hook'

require_relative 'modal'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module BluePrint
    module Composite
      #Modal composite class, passing method to adapter only
      #Hoping to improve code completion and standard interface where
      #classes use this as a template to add additional adapters
      class Modal < Base
        # @return [Array<Symbol>]
        def included_views
          self.adapter.screens
        end

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