# frozen_string_literal: true

require_relative '_base'
require_relative '_proxy'
require_relative '_error'

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
      # @param [AutomationObject::State::Screen] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super Modal, blue_prints, state, name
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        return super if Modal.methods.include?(method)

        # Attempt to load modal if composite object contains that child
        @state.utilize if @subject.to_h.include?(method)

        super
      end

      # @return [Boolean]
      def active?
        @state.active?
      end

      # Go to this modal
      # Will try to automatically reach it, will throw error if it cannot
      # @raise [AutomationObject::Dsl::Error::AutoReachModalError]
      # @return [void]
      def go
        raise AutomationObject::Dsl::Error::AutoReachModalError, @name unless @state.go
      end

      # Retrieve element from composite
      # @param name [String, Symbol] name of element
      # @raise [AutomationObject::Dsl::Error::ElementDoesNotExistError]
      # @return [AutomationObject::Dsl::ElementProxy]
      def element(name)
        name = name.to_sym
        raise AutomationObject::Dsl::Error::ElementDoesNotExistError, name unless @subject.to_h.include?(name)

        @state.utilize
        @subject.send(name)
      end

      # Retrieve element array from composite
      # @param name [String, Symbol] name of element array
      # @raise [AutomationObject::Dsl::Error::ElementArrayDoesNotExistError]
      # @return [AutomationObject::Dsl::ElementArrayProxy]
      def element_array(name)
        name = name.to_sym
        raise AutomationObject::Dsl::Error::ElementArrayDoesNotExistError, name unless @subject.to_h.include?(name)

        @state.utilize
        @subject.send(name)
      end

      # Retrieve element hash from composite
      # @param name [String, Symbol] name of element hash
      # @raise [AutomationObject::Dsl::Error::ElementHashDoesNotExistError]
      # @return [AutomationObject::Dsl::ElementHashProxy]
      def element_hash(name)
        name = name.to_sym
        raise AutomationObject::Dsl::Error::ElementHashDoesNotExistError, name unless @subject.to_h.include?(name)

        @state.utilize
        @subject.send(name)
      end
    end
  end
end
