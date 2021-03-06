# frozen_string_literal: true

# Require parent class
require_relative 'base'

require_relative 'screen'
require_relative 'view'

module AutomationObject
  module BluePrint
    module Composite
      # Top composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class Top < Base
        # @return [Hash<AutomationObject::BluePrint::Composite::Screen>]
        def screens
          adapter.screens
        end

        # @return [Hash<AutomationObject::BluePrint::Composite::View>]
        def views
          adapter.views
        end

        # @return [String, nil] base url to navigate to upon framework creation
        def base_url
          adapter.base_url
        end

        # @return [Symbol, nil] default screen to be set when framework is created
        def default_screen
          adapter.default_screen
        end

        # @return [Numeric] sleep when transitioning screens
        def screen_transition_sleep
          adapter.screen_transition_sleep
        end

        # @return [Hash] driver methods to throttle
        def throttle_driver_methods
          adapter.throttle_driver_methods
        end

        # @return [Hash] element methods to throttle
        def throttle_element_methods
          adapter.throttle_element_methods
        end
      end
    end
  end
end
