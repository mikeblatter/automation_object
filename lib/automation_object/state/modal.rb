# frozen_string_literal: true
require_relative '_base'
require_relative '_error'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module State
    # Modal composite for managing state
    class Modal < Base
      has_one :load, interface: Hook

      has_many :elements, interface: Element
      has_many :element_arrays, interface: ElementArray
      has_many :element_hashes, interface: ElementHash

      def utilize
        raise ModalNotActiveError, name unless active?
      end

      # Whether or not modal is active
      attr_accessor :active

      # @return [Boolean] screen is active or not
      def active?
        @active ||= false
      end

      # Automatically find a way to go to this modal
      # @return [Boolean]
      def go
        # Go to screen first then try to activate modal
        screen.go

        if active?
          utilize
          return true
        end

        false
      end

      def activate
        @active = true
      end

      def deactivate
        @active = false
        reset
      end

      def reset
        elements.values.map(&:reset)
        element_arrays.values.map(&:reset)
        element_hashes.values.map(&:reset)
      end
    end
  end
end
