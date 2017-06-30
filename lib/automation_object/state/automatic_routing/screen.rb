module AutomationObject
  module State
    module AutomaticRouting
      class Screen
        # @param [AutomationObject::State::Top] top_state
        # @param [Symbol] target_screen
        def initialize(top_state, target_screen)
          @top = top_state
          @target_screen = target_screen
        end

        # @return [Boolean] success or not
        def route_to
          screen_transitions = {}

          @top.active_screens.each { |key, value|
            screen_transitions[key] = {}
            value.screen_changes.each { |screen_name|
            }

            puts value.screen_changes
          }

          return false
        end

        private

        def screen_by_key(screen_name)
          @top.screens[screen_name]
        end
      end
    end
  end
end