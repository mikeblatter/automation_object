# frozen_string_literal: true

require_relative 'base'

module AutomationObject
  module PageObject
    class HookAction
      include AutomationObject::PageObject::Base

      # Get the order to run the hook in
      # @return [Array<Symbol>] list of hook methods to run in given order
      def hook_order
        self.class.options[:hook_order]
      end

      # @return [Symbol, nil] screen to change to
      def change_screen
        self.class.options[:change_screen]
      end

      # @return [Symbol, nil] new screen
      def new_screen
        self.class.options[:new_screen]
      end

      # @return [Boolean]
      def close_screen
        self.class.options[:close_screen]
      end

      # @return [Boolean]
      def close_modal
        self.class.options[:close_modal]
      end

      # @return [Boolean]
      def change_to_previous_screen
        self.class.options[:change_to_previous_screen]
      end

      # @return [Symbol, nil]
      def show_modal
        self.class.options[:show_modal]
      end

      # @return [Array]
      def possible_screen_changes
        self.class.options[:possible_screen_changes]
      end

      # @return [Boolean] reset the screen?
      def reset_screen
        self.class.options[:reset_screen]
      end

      # @return [Numeric] amount of time to sleep
      def sleep
        self.class.options[:sleep]
      end

      # Custom method for array of children instead of Hash
      # @return [Array<AutomationObject::BluePrint::Composite::HookElementRequirements>] array of wait for element children
      def wait_for_elements
        self.class.options[:wait_for_elements]
      end

      class << self
        # Set the order to run the hook in
        # @param [Array<Symbol>] hook_order
        def hook_order(hook_order)
          options[:hook_order] = hook_order
        end

        # @param [Symbol] screen_name
        def change_screen(screen_name)
          options[:change_screen] = screen_name
        end

        # @param [Symbol] screen_name
        def new_screen(screen_name)
          options[:new_screen] = screen_name
        end

        # @param [Boolean] bool
        def close_screen(bool)
          options[:close_screen] = bool
        end

        # @param [Boolean] bool
        def close_modal(bool)
          options[:close_modal] = bool
        end

        # @param [Boolean] bool
        def change_to_previous_screen(bool)
          options[:change_to_previous_screen] = bool
        end

        # @param [Symbol]
        def show_modal(model_name)
          options[:show_modal] = model_name
        end

        # @param [Array<Symbol>]
        def possible_screen_changes(screen_names)
          options[:possible_screen_changes] = screen_names
        end

        # @param [Boolean] bool
        def reset_screen(bool)
          options[:reset_screen] = bool
        end

        # @param [Numeric] time
        def sleep(time)
          options[:sleep] = time
        end

        # Custom method for array of children instead of Hash
        # @return [Array<AutomationObject::PageObject::HookElementRequirements>] element_requirements
        def wait_for_elements(element_requirements)
          options[:wait_for_elements] = element_requirements
        end
      end
    end
  end
end
