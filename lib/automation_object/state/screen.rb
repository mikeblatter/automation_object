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

require_relative 'automatic_routing/screen'

module AutomationObject
  module State
    # Screen composite for managing state
    class Screen < Base
      attr_accessor :modal, :window_handle, :previous_screen_name

      # @return [AutomaticScreenChanges]
      attr_accessor :automatic_screen_changes

      has_one :load, interface: Hook

      # Children for this composite
      #has_many :automatic_modal_changes, interface: AutomaticModalChange
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

      # Automatically find a way to go to this screen
      # @return [Boolean]
      def go
        if active?
          utilize
          return true
        end

        AutomaticRouting::Screen.new(self.top, self.name).route_to()
      end

      # @return [void]
      def activate
        @active = true
        self.window_handle = driver.window_handle

        return if blue_prints.automatic_screen_changes.length == 0

        # Add automatic screen change to a new thread and test for screen changes
        self.automatic_screen_changes = AutomaticScreenChanges.new(driver,
                                                                   blue_prints.automatic_screen_changes,
                                                                   :automatic_screen_changes,
                                                                   self,
                                                                   self.location+'[automatic_screen_changes]')
        self.automatic_screen_changes.activate
      end

      # @return [void]
      def deactivate
        self.automatic_screen_changes.deactivate if self.automatic_screen_changes

        self.automatic_screen_changes, self.window_handle = nil
        @active = false

        modals.values.map(&:deactivate)
        reset
      end

      # @return [void]
      def utilize
        raise ScreenNotActiveError.new(name) unless active?
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

      # @return [void]
      def reset
        elements.values.map(&:reset)
        element_arrays.values.map(&:reset)
        element_hashes.values.map(&:reset)
      end

      # @return [Array<Symbol>]
      def screen_changes
        blue_prints.screen_changes
      end

      # @return [Array<Symbol>]
      def modal_changes
        blue_prints.modal_changes
      end
    end
  end
end
