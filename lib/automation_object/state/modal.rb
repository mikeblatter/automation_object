# frozen_string_literal: true
require_relative '_base'
require_relative '_error'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

require_relative 'helpers/container_helper'

module AutomationObject
  module State
    # Modal composite for managing state
    class Modal < Base
      include ContainerHelper

      has_one :load, interface: Hook

      has_many :elements, interface: Element
      has_many :element_arrays, interface: ElementArray
      has_many :element_hashes, interface: ElementHash

      def utilize
        raise ModalNotActiveError, name unless active?
      end

      def activate
        @active = true
      end

      def deactivate
        @active = false
        reset
      end
    end
  end
end
