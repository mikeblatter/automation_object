#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

#Require framework
require_relative '../lib/automation_object'

#Using to simulate simple website
require_relative 'rails_app'

program :version, '0.0.1'
program :description, 'CMD program to test AutomationObject'

command :cli do |c|
  c.syntax = 'ruby main.rb cli [options]'
  c.summary = 'Runs CMD Program and allow use of ao variable'
  c.description = 'Will start up driver and AutomationObject. After will run loop letting you input commands to the ao variable.'
  c.example 'description', 'command example'
  c.action do |args, options|
    say "- Can operate on the variable ao for AutomationObject"
    say "- Example: ao.home_screen.logo_button"
    say "- Wait for first ask to run command"
    say "----------------------------------------------------"

    @rails_app = RailsApp.new
    @rails_app.create


    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    at_exit {
      @driver.quit
    }

    ao = AutomationObject::Framework.new(driver: @driver,
                                                         blue_prints: File.expand_path(File.join(__dir__, 'blue_prints/')))

    loop do
      command = ask 'Execute CMD (exit to quit): '
      if command.match(/exit/) or command.match(/quit/)
        break
      end

      begin
        ap eval(command)
      rescue Exception => e
        ap e
        puts e.backtrace
      end
    end
  end
end

command :cucumber do |c|
  c.syntax = 'ruby main.rb cucumber [options]'
  c.action do |args, options|
    `cucumber`
  end
end










