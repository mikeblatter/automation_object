# frozen_string_literal: true

require_relative '_base'
require_relative '_proxy'
require_relative '_error'

require_relative 'modal'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module Dsl
    # Screen DSL Class
    class Screen < Base
      has_many :modals, ModalProxy
      has_many :elements, ElementProxy
      has_many :element_arrays, ElementArrayProxy
      has_many :element_hashes, ElementHashProxy
    end

    # Proxy for Screen
    class ScreenProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::Screen] blue_prints
      # @param [AutomationObject::State::Top] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super Screen, blue_prints, state, name
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        return super if Screen.methods.include?(method)

        # Attempt to load screen if composite object contains that child
        @state.utilize if @subject.to_h.include?(method)

        super
      end

      # Is the screen active
      # @return [Boolean]
      def active?
        @state.active?
      end

      # Close screen
      # @return [void]
      def close
        @state.close
      end

      # Go to this screen
      # Will try to automatically reach it, will throw error if it cannot
      # @raise [AutomationObject::Dsl::Error::AutoReachScreenError]
      # @return [void]
      def go
        raise AutomationObject::Dsl::Error::AutoReachScreenError, @name unless @state.go
      end

      # Retrieve modal from composite
      # @param name [String, Symbol] name of modal
      # @raise [AutomationObject::Dsl::Error::ModalDoesNotExistError]
      # @return [AutomationObject::Dsl::ModalProxy]
      def modal(name)
        name = name.to_sym
        raise AutomationObject::Dsl::Error::ModalDoesNotExistError, name unless @subject.to_h.include?(name)

        @state.utilize
        @subject.send(name)
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
