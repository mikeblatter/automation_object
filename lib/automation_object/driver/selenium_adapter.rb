require_relative 'selenium_adapter/driver'

module AutomationObject::Driver
  #SeleniumAdapter module for adapting Selenium to the Driver interface
  module SeleniumAdapter
    extend self

    def new(driver)
      return Driver.new(driver)
    end
  end
end