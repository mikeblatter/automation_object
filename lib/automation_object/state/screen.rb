# frozen_string_literal: true

require_relative '_base'
require_relative '_error'

require_relative 'automatic_modal_change'
require_relative 'automatic_screen_changes'
require_relative 'modal'
require_relative 'hook'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

require_relative 'helpers/automatic_routing'
require_relative 'helpers/container_helper'

module AutomationObject
  module State
    # Screen composite for managing state
    class Screen < Base
      include ContainerHelper

      attr_accessor :modal, :window_handle, :previous_screen_name

      # @return [AutomaticScreenChanges]
      attr_accessor :automatic_screen_changes

      has_one :load, interface: Hook

      # Children for this composite
      # has_many :automatic_modal_changes, interface: AutomaticModalChange
      has_many :modals, interface: Modal

      has_many :elements, interface: Element
      has_many :element_arrays, interface: ElementArray
      has_many :element_hashes, interface: ElementHash

      # @return [void]
      def activate
        @active = true
        self.window_handle = driver.window_handle

        return if blue_prints.automatic_screen_changes.empty?

        # Add automatic screen change to a new thread and test for screen changes
        self.automatic_screen_changes = AutomaticScreenChanges.new(driver,
                                                                   blue_prints.automatic_screen_changes,
                                                                   :automatic_screen_changes,
                                                                   self,
                                                                   location + '[automatic_screen_changes]')
        automatic_screen_changes.activate
      end

      # @return [void]
      def deactivate
        automatic_screen_changes&.deactivate

        self.automatic_screen_changes, self.window_handle = nil
        @active = false

        modals.values.map(&:deactivate)
        reset
      end

      # @return [void]
      def utilize
        raise ScreenNotActiveError, name unless active?
        driver.window_handle = window_handle
      end

      # @return [void]
      def close
        utilize
        driver.close
        deactivate
      end

      # @return [Boolean]
      def closed?
        !driver.window_handles.include?(window_handle)
      end
    end
  end
end
