require_relative 'base'

module AutomationObject
  module PageObject
    class Configuration < Base
      class << self
        # Set base url
        # @param url [String] base url
        def base_url(url)
          set_property(:base_url, url)
        end

        # @param name [Const]
        def default_screen(name)
          set_property(:default_screen, name)
        end

        # @param time [Numeric]
        def screen_transition_sleep(time)
          set_property(:screen_transition_sleep, time)
        end

        # @param hash [Hash]
        def throttle_driver_methods(hash)
          set_property(:throttle_driver_methods, hash)
        end

        # @param hash [Hash]
        def throttle_element_methods(hash)
          set_property(:throttle_element_methods, hash)
        end
      end
    end
  end
end