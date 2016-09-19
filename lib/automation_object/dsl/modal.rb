# frozen_string_literal: true
require_relative '_base'
require_relative '_proxy'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module Dsl
    # Modal DSL Class
    class Modal < Base
      has_many :elements, ElementProxy
      has_many :element_arrays, ElementArrayProxy
      has_many :element_hashes, ElementHashProxy
    end

    # Proxy for Modal
    class ModalProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::Modal] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super Modal, blue_prints, state, name
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        # If Modal class has the method defined, then don't load
        return super if Modal.method_defined?(method)

        puts "@state.load(:modal, #{@name})"
        @state.load(:modal, @name)

        super
      end
    end
  end
end
