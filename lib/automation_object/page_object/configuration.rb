# frozen_string_literal: true

module AutomationObject
  module PageObject
    class Configuration
      class << self
        # Sets the base url for AutomationObject to start at
        # @return [String, nil] base url for testing
        attr_accessor :base_url

        # Sets the base url for AutomationObject to start at
        # @return [String, nil] base url for testing
        attr_accessor :default_screen

        # Sets sleep time in seconds to wait between switch screens
        # This is to help when starting testing, should use hooks to know when on a page
        # will operate faster through checks then brittle sleeps
        # @return [Number, nil] base url for testing
        attr_accessor :screen_transition_sleep

        # Throttles driver methods to seconds specified in hash
        # @return [Hash<Symbol, Number>, nil] symbols and minimum run time for method
        attr_accessor :throttle_driver_methods

        # Throttles element methods to seconds specified in hash
        # @return [Hash<Symbol, Number>, nil] symbols and minimum run time for method
        attr_accessor :throttle_element_methods
      end
    end
  end
end
