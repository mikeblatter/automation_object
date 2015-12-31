#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

require_relative '../lib/automation_object'

program :version, '0.0.1'
program :description, 'CMD program to test AutomationObject'

command :run do |c|
  c.syntax = 'ruby main.rb run [options]'
  c.summary = 'Runs CMD Program and allow use of ao variable'
  c.description = 'Will start up driver and AutomationObject. After will run loop letting you input commands to the ao variable.'
  c.example 'description', 'command example'
  c.action do |args, options|
    begin
      raw_driver = Selenium::WebDriver.for :chrome

      ao = AutomationObject::Framework.new(driver: raw_driver,
                                           blue_prints: File.expand_path(File.join(__dir__, 'blue_prints/')))

      say "Can operate on the variable ao for AutomationObject"
      say "Example: ao.home_screen.logo_button"
      say "Which will be executed via eval()"

      loop do
        command = ask 'Execute CMD (exit to quit): '
        if command.match(/exit/) or command.match(/quit/)
          break
        end

        begin
          ap eval(command)
        rescue Exception => e
          puts 'Error occurred'.colorize(:red)
          ap e
          ap e.class
          ap e.message
          ap e.backtrace
        end
      end
    ensure
      raw_driver.quit
    end
  end
end

