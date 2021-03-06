# frozen_string_literal: true

# Require parent class
require_relative 'composite'
require_relative 'hook_element_requirements'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Hook action composite
      class HookAction < Composite
        # Call the wait_for_elements method to generate the children
        before_create :wait_for_elements

        # Validations
        validates_keys allowed_keys: %i[new_screen show_modal close_screen change_screen
                                        sleep wait_for_elements change_to_previous_screen close_modal reset_screen
                                        possible_screen_changes]

        validates :change_screen, instance_of: [String, Symbol], screen_presence_of: true
        validates :new_screen, instance_of: [String, Symbol], screen_presence_of: true
        validates :change_to_previous_screen, instance_of: TrueClass
        validates :close_modal, instance_of: TrueClass
        validates :close_screen, instance_of: TrueClass
        validates :possible_screen_changes, instance_of: Array, screen_presence_of: true
        validates :reset_screen, instance_of: TrueClass
        validates :show_modal, instance_of: String, modal_presence_of: true
        validates :sleep, instance_of: Numeric
        validates :wait_for_elements, instance_of: Array

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
