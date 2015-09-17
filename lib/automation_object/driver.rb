require_relative 'proxies/throttle_proxy'
require_relative 'proxies/mutex_proxy'

module AutomationObject
  #Driver Port
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
      adapter_name << '_adapter' unless adapter_name.match(/_adapter$/)
      adapter_const = adapter_name.pascalize

      require_relative "driver/#{adapter_name}"
      @adapter = AutomationObject::Driver.const_get("#{adapter_const}")
    end

    def new(*args)
      adapter_instance = self.adapter.new(*args)

      #Add throttling and mutex proxies around adapter
      throttled_adapter_instance = AutomationObject::Proxies::ThrottleProxy.new(adapter_instance)

      #Will protect from IO errors on driver
      protected_adapter_instance = AutomationObject::Proxies::MutexProxy.new(throttled_adapter_instance)

      return protected_adapter_instance
    end
  end
end