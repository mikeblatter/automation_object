# frozen_string_literal: true

require_relative 'base'

module AutomationObject
  module PageObject
    class Configuration
      include AutomationObject::PageObject::Base

      # Base url for AutomationObject to start at
      # @return [String, nil]
      def base_url
        self.class.options[:base_url]
      end

      # Default screen for AutomationObject to start at
      # @return [Symbol, nil]
      def default_screen
        self.class.options[:default_screen]
      end

      # Sleep time in seconds to wait between switch screens
      # @return [Number, nil]
      def screen_transition_sleep
        self.class.options[:screen_transition_sleep]
      end

      # Throttles driver methods to seconds specified in hash
      # @return [Hash<Symbol, Number>]
      def throttle_driver_methods
        self.class.options[:throttle_driver_methods]
      end

      # Throttles element methods to seconds specified in hash
      # @return [Hash<Symbol, Number>]
      def throttle_element_methods
        self.class.options[:throttle_element_methods]
      end

      class << self
        # Sets the base url for AutomationObject to start at
        # @param [String] url
        def base_url(url)
          options[:base_url] = url
        end

        # Sets the default screen for AutomationObject to start at
        # @param [String, Symbol] screen
        def default_screen(screen)
          options[:default_screen] = screen
        end

        # Sets sleep time in seconds to wait between switch screens
        # This is to help when starting testing, should use hooks to know when on a page
        # will operate faster through checks then brittle sleeps
        # @param [Number] time
        def screen_transition_sleep(time)
          options[:screen_transition_sleep] = time
        end

        # Throttles driver methods to seconds specified in hash
        # @param [Hash<Symbol, Number>] methods_to_time
        def throttle_driver_methods(methods_to_time)
          options[:throttle_driver_methods] = methods_to_time
        end

        # Throttles element methods to seconds specified in hash
        # @param [Hash<Symbol, Number>] methods_to_time
        def throttle_element_methods(methods_to_time)
          options[:throttle_element_methods] = methods_to_time
        end
      end
    end
  end
end
