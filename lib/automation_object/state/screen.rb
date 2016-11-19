# frozen_string_literal: true
require_relative '_base'
require_relative '_error'

require_relative 'modal'
require_relative 'hook'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module State
    # Screen composite for managing state
    class Screen < Base
      attr_accessor :modal, :window_handle, :previous_screen_name

      has_one :load, interface: Hook

      # Children for this composite
      has_many :modals, interface: Modal

      has_many :elements, interface: Element
      has_many :element_arrays, interface: ElementArray
      has_many :element_hashes, interface: ElementHash

      # Whether or not modal is active
      attr_accessor :active

      # @return [Boolean] screen is active or not
      def active?
        @active ||= false
      end

      def activate
        @active = true
        self.window_handle = driver.window_handle
      end

      def deactivate
        @active = false
        self.window_handle = nil
        modals.values.map(&:deactivate)
        reset
      end

      def utilize
        raise ScreenNotActiveError, name unless active?
        driver.window_handle = window_handle if window_handle != driver.window_handle
      end

      def close
        raise ScreenNotActiveError, name unless active?

        driver.window_handle = window_handle if window_handle != driver.window_handle
        driver.close
      end

      # @return [Boolean]
      def closed?
        !driver.window_handles.include?(window_handle)
      end

      def reset
        elements.values.map(&:reset)
        element_arrays.values.map(&:reset)
        element_hashes.values.map(&:reset)
      end
    end
  end
end
