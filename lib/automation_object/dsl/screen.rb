# frozen_string_literal: true
require_relative '_base'
require_relative '_proxy'

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
      # @param [AutomationObject::State::Top] top state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        screen_state = state.screens[name]
        super Screen, blue_prints, screen_state, name
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

      # @return [Boolean]
      def active?
        @state.active?
      end

      # Close screen
      def close
        @state.close
      end
    end
  end
end
