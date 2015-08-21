require_relative 'nokogiri_adapter/error'
require_relative 'nokogiri_adapter/driver'

module AutomationObject::Driver
  #NokogiriAdapter module for adapting Nokogiri to the Driver interface
  module NokogiriAdapter
    extend self

    def new(args={})
      return Driver.new(args)
    end
  end
end