#Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      #View composite, no children, merges into screens then screens will add children here
      #Helpful to have validations before merging the hashes, that way errors show in the correct place
      class View < Base
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