# frozen_string_literal: true

require_relative 'automation_object/helpers/kernel'

# Require Gems
# Ignore warning coming from third-party libraries
Kernel.suppress_warnings do
  require 'awesome_print'
  require 'ostruct'
  require 'event_emitter'
  require 'appium_lib'
  require 'selenium-webdriver'
end

# Local Files
require_relative 'automation_object/version'

# Class method additions
require_relative 'automation_object/helpers/string'
require_relative 'automation_object/helpers/hash'

# Core Framework
require_relative 'automation_object/framework'

# Cucumber Step Definitions
require_relative 'automation_object/step_definitions'

# Top level namespace
# AutomationObject is a dynamic DSL framework created by configurations that
# allow for UI automation using business logic
module AutomationObject
end
