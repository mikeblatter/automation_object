require_relative '../lib/automation_object'

raw_driver = Selenium::WebDriver.for :chrome
framework = AutomationObject::Framework.new({
                                    :blue_print_type => :yaml,
                                    :blue_prints => File.join(File.expand_path(File.dirname(__FILE__)), 'test_blueprints'),
                                    :driver_type => :selenium,
                                    :driver => raw_driver
                                })
#ap framework.home_screen