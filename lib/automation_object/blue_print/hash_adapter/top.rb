# frozen_string_literal: true
# Require parent class
require_relative 'composite'

# Require child classes
require_relative 'screen'
require_relative 'view'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Top composite
      class Top < Composite
        # Relationships
        has_many :screens, interface: Screen
        has_many :views, interface: View

        # Validations
        validates_keys allowed_keys: [:base_url, :default_screen, :screen_transition_sleep, :screens,
                                      :throttle_driver_methods, :throttle_element_methods, :views]

        validates :base_url, instance_of: String
        validates :default_screen, instance_of: [Symbol, String], screen_presence_of: true
        validates :screen_transition_sleep, instance_of: Numeric
        validates :screens, instance_of: Hash
        validates :throttle_driver_methods, instance_of: Hash
        validates :throttle_element_methods, instance_of: Hash
        validates :views, instance_of: Hash

        # @return [String, nil] base url to navigate to upon framework creation
        def base_url
          hash[:base_url] ||= nil
        end

        # @return [Symbol, nil] default screen to be set when framework is created
        def default_screen
          default_screen = hash[:default_screen]

          case default_screen
          when Symbol, String
            return default_screen.to_sym
          else
            return nil
          end
        end

        # @return [Numeric] sleep when transitioning screens
        def screen_transition_sleep
          hash[:screen_transition_sleep] ||= 0
        end

        # @return [Hash] driver methods to throttle
        def throttle_driver_methods
          hash[:throttle_driver_methods] ||= {}
        end

        # @return [Hash] element methods to throttle
        def throttle_element_methods
          hash[:throttle_element_methods] ||= {}
        end
      end
    end
  end
end
