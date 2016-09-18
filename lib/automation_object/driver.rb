require_relative 'helpers/string'

require_relative 'proxy/throttle_proxy'
require_relative 'proxy/mutex_proxy'

require_relative 'driver/driver'

# Adapters
require_relative 'driver/appium_adapter/driver'
require_relative 'driver/nokogiri_adapter/driver'
require_relative 'driver/selenium_adapter/driver'

module AutomationObject
  # Driver Port
  module Driver
    extend self

    def adapter
      return @adapter if @adapter
      self.adapter = :nokogiri
      @adapter
    end

    # Sets adapter const will append _adapter if needed
    # @param adapter_name [String] name of adapter wanted for composite creation
    def adapter=(adapter_name)
      adapter_name = adapter_name.to_s
      adapter_name << '_adapter' unless adapter_name =~ /_adapter$/
      adapter_const = adapter_name.pascalize

      @adapter = AutomationObject::Driver.const_get(adapter_const.to_s)::Driver
    end

    # @param driver [Object] selenium or appium driver. default nil for Nokogiri
    # @return [AutomationObject::Driver::Driver]
    def new(driver = nil)
      adapted_driver = Driver.new(adapter.new(driver))

      # Add throttling and mutex proxies around adapter
      AutomationObject::Proxy::MutexProxy.new(
        AutomationObject::Proxy::ThrottleProxy.new(adapted_driver)
      )
    end
  end
end
