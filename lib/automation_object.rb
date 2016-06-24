#Gems
require 'awesome_print'
require 'colorize'
require 'ostruct'
require 'event_emitter'
require 'appium_lib'
require 'selenium-webdriver'

#Local Files
require_relative 'automation_object/version'

#Class method additions
require_relative 'automation_object/helpers/string'
require_relative 'automation_object/helpers/hash'

#Core Framework
require_relative 'automation_object/framework'

module AutomationObject
end