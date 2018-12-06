# frozen_string_literal: true

require_relative 'composite'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # HockAction composite
      class HockAction < Composite
        # Get the order to run the hook in
        # @return [Array<Symbol>] list of hook methods to run in given order
        def hook_order
          hash.keys
        end

        # Get length of hook actions
        # @return [Integer] length of hook actions
        def length
          hash.keys.length
        end

        # See if hook actions are empty
        # @return [Boolean] if hook actions are empty
        def empty?
          hash.keys.empty?
        end

        # @return [Symbol, nil] screen to change to
        def change_screen
          change_screen = hash[:change_screen]

          case change_screen
          when Symbol, String
            return change_screen.to_sym
          else
            return nil
          end
        end

        # @return [Symbol, nil] new screen
        def new_screen
          new_screen = hash[:new_screen]

          case new_screen
          when Symbol, String
            return new_screen.to_sym
          else
            return nil
          end
        end

        # @return [Boolean]
        def close_screen
          hash[:close_screen] ||= false
        end

        # @return [Boolean]
        def close_modal
          hash[:close_modal] ||= false
        end

        # @return [Boolean]
        def change_to_previous_screen
          hash[:change_to_previous_screen] ||= false
        end

        # @return [Symbol, nil]
        def show_modal
          show_modal = hash[:show_modal]

          case show_modal
          when Symbol, String
            return show_modal.to_sym
          else
            return nil
          end
        end

        # @return [Array]
        def possible_screen_changes
          return hash[:possible_screen_changes].map(&:to_sym) if hash[:possible_screen_changes].is_a?(Array)

          []
        end

        # @return [Boolean] reset the screen?
        def reset_screen
          hash[:reset_screen] ||= false
        end

        # @return [Numeric] amount of time to sleep
        def sleep
          hash[:sleep] ||= 0
        end

        # Custom method for array of children instead of Hash
        # @return [Array<HookElementRequirements>] array of wait for element children
        def wait_for_elements
          return @wait_for_elements if defined? @wait_for_elements

          wait_for_elements = hash[:wait_for_elements]

          children = wait_for_elements.is_a?(Array) ? wait_for_elements : []
          @wait_for_elements = create_array_children(:wait_for_elements, children,
                                                     interface: HookElementRequirements,
                                                     location: location + '[wait_for_elements]')

          @wait_for_elements
        end
      end
    end
  end
end
