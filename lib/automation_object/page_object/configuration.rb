module AutomationObject
  module PageObject
    class Configuration
      class << self
        # Set base url
        # @param url [String] base url
        def base_url(url)
          @base_url = url
        end

        # @param name [Const]
        def default_screen(name)
          @default_screen = name
        end

        # @param time [Numeric]
        def screen_transition_sleep(time)
          @screen_transition_sleep = time
        end

        # @param hash [Hash]
        def throttle_driver_methods(hash)
          @throttle_driver_methods = hash
        end

        # @param hash [Hash]
        def throttle_element_methods(hash)
          @throttle_element_methods = hash
        end
      end
    end
  end
end