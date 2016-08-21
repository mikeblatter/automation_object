require_relative 'support/cache'
require_relative 'support/parse'

# Screen related step definitions
#
# Warning: Examples documentation is parsed and turned into unit tests checked the step definition regex
# This is to make sure that the examples in the docs will actually perform as indicated
# Please follow what is already defined below

# Close the current screen
#
# Examples:
# - I close the screen
# - I destroy the screen
Then(/^I (?:close|destroy) the screen$/) do
  AutomationObject::Framework.get.current_screen.close
end

# Close a given screen
#
# Examples:
# - I close the "home" screen
# - I destroy the "home" screen
Then(/^I (?:close|destroy)(?: the)? "([\w\s]+|%\{[\w\d]+\})" screen$/) do |*args|
  screen = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.screen(screen).close
end

# Navigate back on the current screen
#
# Examples:
# - I navigate back on the screen
Then(/^I (?:navigate|go) back (?:on )?(?:the )?screen$/) do
  AutomationObject::Framework.get.current_screen.back
end

# Navigate back on a given screen
#
# Examples:
# - I navigate back on the "contact" screen
Then(/^I (?:navigate|go) back (?:on )?(?:the )?"([\w\s]+|%\{[\w\d]+\})" screen$/) do |*args|
  screen = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.screen(screen).back
end

# Switch/Focus screen
#
# Examples:
# - I switch to the "home" screen
# - I focus the "contact" screen
Then(/^I (?:switch|focus) (?:to )?(?:the )?"([\w\s]+|%\{[\w\d]+\})" screen$/) do |*args|
  screen = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.focus(screen)
end