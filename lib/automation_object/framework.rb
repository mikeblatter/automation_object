require_relative 'proxy/proxy'
require_relative 'blue_print'
require_relative 'driver'
require_relative 'dsl'
require_relative 'state'

module AutomationObject
  #Framework class, the core
  #A Proxy class that will become the DSL Framework
  class Framework < Proxy::Proxy
    # @return [AutomationObject::BluePrint::Composite::Top]
    attr_accessor :blue_prints

    # @return [AutomationObject::Driver::Driver]
    attr_accessor :driver

    # @return [AutomationObject::State::Session]
    attr_accessor :state

    # @return [Dsl] workable dsl composite object
    attr_accessor :dsl

    # Will assume nil or :nokogiri is XML based and AutomationObject
    # can also automate XML
    # @param driver [Selenium::WebDriver::Driver,Appium::Driver,nil] selenium type driver or nil
    # @param blue_prints [Hash] arguments for Framework
    def initialize(driver, blue_prints)
      self.driver = driver
      self.blue_prints = blue_prints

      self.state = State.new(self.driver, self.blue_prints)
      @subject = Dsl.new(self.blue_prints, self.state)

      AutomationObject::Framework.singleton = self
    end

    # BluePrints (UI configurations) wrapped in an composite
    # Composite provides a common interface for all adapters
    # @param value [String, Hash] String to YAML files or Hash configuration
    # @return [AutomationObject::BluePrint::Composite::Top] top composite object
    def blue_prints=(value)
      case value
        when String
          BluePrint.adapter = :yaml
        when Hash
          BluePrint.adapter = :hash
      end

      @blue_prints = BluePrint.new(value)
    end

    # Driver port provides a formatted interface for interacting with different drivers
    # @return [AutomationObject::Driver::Driver] driver interface object
    def driver=(value)
      case value
        when Selenium::WebDriver::Driver
          Driver.adapter = :selenium
        when Appium::Driver
          Driver.adapter = :appium
        else
          Driver.adapter = :nokogiri
      end

      @driver = Driver.new(value)
    end

    # Reset the entire state, remove any values
    # Leave the driver alone here, can be done elsewhere
    # @return [void]
    def quit
      self.state.quit #Quit the state.  That way it knows to kill threads if operational
      self.dsl, self.state, self.blue_prints, self.driver = nil
    end

    # Static Hack
    # TODO: figure a multiple instance way of using ao in Cucumber context
    # Leaving for now to continue testing and building of whole framework
    class << self
      attr_accessor :singleton

      #Singleton method if using Cucumber
      # @return [Framework] singleton of self
      def get
        return self.singleton
      end
    end
  end
end