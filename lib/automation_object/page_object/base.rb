require_relative 'base'

module AutomationObject
  module PageObject
    class Base
      class << self
        attr_accessor :configuration

        undef :configuration if defined? :configuration
        def configuration
          @configuration ||= {}
        end

        def set_property(name, value)
          self.configuration[name] = value
        end

        def get_property(name)
          self.configuration[name]
        end
      end
    end
  end
end