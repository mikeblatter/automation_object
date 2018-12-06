# frozen_string_literal: true

# Set up Java Drivers
drivers_path = File.expand_path(File.join(__dir__, 'drivers/'))
ENV['SELENIUM_SERVER_JAR'] = drivers_path
ENV['PATH'] = "#{drivers_path}:" + ENV['PATH']

require 'pry'
require_relative 'rails_app'
require_relative '../lib/automation_object/driver'

# Create new rails app, self cleaning on exit
RailsApp.new

AutomationObject::Driver.adapter = :nokogiri
driver = AutomationObject::Driver.create

driver.get("http://localhost:#{RailsApp::PORT}")

# Allow user to debug using pry
binding.pry
