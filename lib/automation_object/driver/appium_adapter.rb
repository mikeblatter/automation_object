require_relative 'appium_adapter/driver'

module AutomationObject::Driver
  #AppiumAdapter module for adapting Selenium to the Driver interface
  module AppiumAdapter
    extend self

    def new(driver)
      return Driver.new(driver)
    end
  end
end