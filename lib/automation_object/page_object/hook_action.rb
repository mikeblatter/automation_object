# frozen_string_literal: true

module AutomationObject
  module PageObject
    class HookAction
      # Get the order to run the hook in
      # @return [Array<Symbol>] list of hook methods to run in given order
      def hook_order
        self.class._hook_order
      end

      # @return [Symbol, nil] screen to change to
      def change_screen
        self.class._change_screen
      end

      # @return [Symbol, nil] new screen
      def new_screen
        self.class._new_screen
      end

      # @return [Boolean]
      def close_screen
        self.class._close_screen
      end

      # @return [Boolean]
      def close_modal
        self.class._close_modal
      end

      # @return [Boolean]
      def change_to_previous_screen
        self.class._change_to_previous_screen
      end

      # @return [Symbol, nil]
      def show_modal
        self.class._show_modal
      end

      # @return [Array]
      def possible_screen_changes
        self.class._possible_screen_changes
      end

      # @return [Boolean] reset the screen?
      def reset_screen
        self.class._reset_screen
      end

      # @return [Numeric] amount of time to sleep
      def sleep
        self.class._sleep
      end

      # Custom method for array of children instead of Hash
      # @return [Array<AutomationObject::BluePrint::Composite::HookElementRequirements>] array of wait for element children
      def wait_for_elements
        self.class._wait_for_elements
      end

      class << self
        attr_reader :_hook_order, :_change_screen, :_new_screen, :_close_screen,
                    :_close_modal, :_change_to_previous_screen, :_show_modal,
                    :_possible_screen_changes, :_reset_screen, :_sleep, :_wait_for_elements

        # Set the order to run the hook in
        # @param [Array<Symbol>] hook_order
        def hook_order(hook_order)
          @_hook_order = hook_order
        end

        # @param [Symbol] screen_name
        def change_screen(screen_name)
          @_change_screen = screen_name
        end

        # @param [Symbol] screen_name
        def new_screen(screen_name)
          @_new_screen = screen_name
        end

        # @param [Boolean] bool
        def close_screen(bool)
          @_close_screen = bool
        end

        # @param [Boolean] bool
        def close_modal(bool)
          @_close_modal = bool
        end

        # @param [Boolean] bool
        def change_to_previous_screen(bool)
          @_close_modal = bool
        end

        # @param [Symbol]
        def show_modal(model_name)
          @_show_modal = model_name
        end

        # @param [Array<Symbol>]
        def possible_screen_changes(screen_names)
          @_possible_screen_changes = screen_names
        end

        # @param [Boolean] bool
        def reset_screen(bool)
          @_reset_screen = bool
        end

        # @param [Numeric] time
        def sleep(time)
          @_sleep = time
        end

        # Custom method for array of children instead of Hash
        # @return [Array<AutomationObject::PageObject::HookElementRequirements>] element_requirements
        def wait_for_elements(element_requirements)
          @_wait_for_elements = element_requirements
        end
      end
    end
  end
end
