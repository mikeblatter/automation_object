# frozen_string_literal: true

module AutomationObject
  module PageObject
    class Configuration
      # Base url for AutomationObject to start at
      # @return [String, nil]
      def base_url
        self.class._base_url
      end

      # Default screen for AutomationObject to start at
      # @return [Symbol, nil]
      def default_screen
        self.class._default_screen
      end

      # Sleep time in seconds to wait between switch screens
      # @return [Number, nil]
      def screen_transition_sleep
        self.class._screen_transition_sleep
      end

      # Throttles driver methods to seconds specified in hash
      # @return [Hash<Symbol, Number>]
      def throttle_driver_methods
        self.class._throttle_driver_methods or {}
      end

      # Throttles element methods to seconds specified in hash
      # @return [Hash<Symbol, Number>]
      def throttle_element_methods
        self.class._throttle_element_methods or {}
      end

      class << self
        attr_reader :_base_url, :_default_screen, :_screen_transition_sleep,
                    :_throttle_driver_methods, :_throttle_element_methods

        # Sets the base url for AutomationObject to start at
        # @param [String] url
        def base_url(url)
          @_base_url = url
        end

        # Sets the default screen for AutomationObject to start at
        # @param [String, Symbol] screen
        def default_screen(screen)
          @_default_screen = screen
        end

        # Sets sleep time in seconds to wait between switch screens
        # This is to help when starting testing, should use hooks to know when on a page
        # will operate faster through checks then brittle sleeps
        # @param [Number] time
        def screen_transition_sleep(time)
          @_screen_transition_sleep = time
        end

        # Throttles driver methods to seconds specified in hash
        # @param [Hash<Symbol, Number>] methods_to_time
        def throttle_driver_methods(methods_to_time)
          @_throttle_driver_methods = methods_to_time
        end

        # Throttles element methods to seconds specified in hash
        # @param [Hash<Symbol, Number>] methods_to_time
        def throttle_element_methods(methods_to_time)
          @_throttle_element_methods = methods_to_time
        end
      end
    end
  end
end
