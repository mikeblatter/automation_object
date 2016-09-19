# frozen_string_literal: true
# Require parent class
require_relative 'base'

require_relative 'automatic_onload_modal'
require_relative 'hook'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module BluePrint
    module Composite
      # Modal composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class Modal < Base
        # @return [Array<Symbol>]
        def included_views
          adapter.screens
        end

        # @return [Hook]
        def load
          adapter.load
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
