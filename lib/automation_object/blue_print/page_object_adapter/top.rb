# frozen_string_literal: true

require_relative 'composite'
require_relative 'screen'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Top composite
      class Top < Composite
        # Relationships
        has_many :screens, interface: Screen

        def initialize(defined_module)
          super(defined_module, defined_module.const_get(:Configuration))
        end

        # @return [String, nil] base url to navigate to upon framework creation
        def base_url
          self.constant.base_url ||= nil
        end

        # @return [Symbol, nil] default screen to be set when framework is created
        def default_screen
          default_screen = self.constant.default_screen

          case default_screen
            when Symbol, String
              return default_screen.to_sym
            else
              return nil
          end
        end

        # @return [Numeric] sleep when transitioning screens
        def screen_transition_sleep
          self.constant.screen_transition_sleep ||= 0
        end

        # @return [Hash] driver methods to throttle
        def throttle_driver_methods
          self.constant.throttle_driver_methods ||= {}
        end

        # @return [Hash] element methods to throttle
        def throttle_element_methods
          self.constant.throttle_element_methods ||= {}
        end
      end
    end
  end
end
