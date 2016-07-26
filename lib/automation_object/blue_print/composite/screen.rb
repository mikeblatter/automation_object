#Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      #Screen-level composite, ActiveRecord style composite implementation inheriting from Composite
      class Screen < Base
        # @return [Array<Symbol>]
        def included_views
          raise NotImplementedError
        end

        # @return [Array<AutomaticOnloadModal>]
        def automatic_onload_modals
          raise NotImplementedError
        end

        # @return [Array<Symbol>]
        def automatic_screen_changes
          raise NotImplementedError
        end

        # @return [Hook]
        def load
          raise NotImplementedError
        end

        # @return [Hash<Modal>]
        def modals
          raise NotImplementedError
        end

        # @return [Hash<Element>]
        def elements
          raise NotImplementedError
        end

        # @return [Hash<ElementArray>]
        def element_arrays
          raise NotImplementedError
        end

        # @return [Hash<ElementHash>]
        def element_hashes
          raise NotImplementedError
        end
      end
    end
  end
end
