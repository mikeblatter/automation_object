# frozen_string_literal: true

# Set up Java Drivers
drivers_path = File.expand_path(File.join(__dir__, 'drivers/'))
ENV['SELENIUM_SERVER_JAR'] = drivers_path
ENV['PATH'] = "#{drivers_path}:" + ENV['PATH']

require 'pry'
require_relative 'rails_app'

# Create new rails app, self cleaning on exit
RailsApp.new

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 3 # seconds

at_exit do
  begin
    driver.quit
  rescue Exception => e
    ap e
  end
end

# Go to rails site
driver.navigate.to("http://localhost:#{RailsApp::PORT}")

# Allow user to debug using pry
binding.pry
