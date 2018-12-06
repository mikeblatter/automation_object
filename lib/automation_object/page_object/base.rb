module AutomationObject
  # PageObject module is the public interface for loading configurations via page objects
  module PageObject
    # Base class for PageObject model
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