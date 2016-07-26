#Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      #Abstract Top class, adapters implemented using extend located in Base
      class Top < Base
        # @return [Array<View>]
        def views
          raise NotImplementedError
        end

        # @return [Array<Screen>]
        def screens
          raise NotImplementedError
        end

        # @return [String, nil] base url to navigate to upon framework creation
        def base_url
          raise NotImplementedError
        end

        # @return [Symbol, nil] default screen to be set when framework is created
        def default_screen
          raise NotImplementedError
        end

        # @return [Numeric] sleep when transitioning screens
        def screen_transition_sleep
          raise NotImplementedError
        end

        # @return [Hash] driver methods to throttle
        def throttle_driver_methods
          raise NotImplementedError
        end

        # @return [Hash] element methods to throttle
        def throttle_element_methods
          raise NotImplementedError
        end
      end
    end
  end
end