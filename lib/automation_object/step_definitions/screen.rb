# frozen_string_literal: true
require_relative 'support/parse'

# Screen Step Definitions
# Provides step definitions related to screens

# Automatically navigate to the modal
# Examples:
# - I go to the "home_screen" screen
# - I go to "login_screen" screen
When(%r(^I go to (?:the |)"([\w\s]+|%\{\w+\})" screen)) do |*args|
  screen = AutomationObject::StepDefinitions::Parse.new(args).get

  success = AutomationObject::Framework.get.screen(screen).go
  expect(success).to eq(true)
end

# Close the current screen or given screen
# Examples:
# - I close the "contact" screen
# - I close the screen
# - I destroy the screen
When(%r(^I (?:close|destroy) the ("([\w\s]+|%\{\w+\})")? ?screen$)) do |*args|
  _unparsed_name, name = AutomationObject::StepDefinitions::Parse.new(args).get

  if name
    AutomationObject::Framework.get.send(name).close
  else
    AutomationObject::Framework.get.current_screen.close
  end
end

# Navigate back on a given or current screen
# Examples:
# - I navigate back on the screen
# - I navigate back on the "contact" screen
When(%r(^I (?:navigate|go) back (?:on )?(?:the )?("([\w\s]+|%\{\w+\})")? ?screen$)) do
  _unparsed_name, name = AutomationObject::StepDefinitions::Parse.new(args).get

  if name
    AutomationObject::Framework.get.screen(name).back
  else
    AutomationObject::Framework.get.current_screen.back
  end
end

# Switch/Focus screen
# Examples:
# - I switch to the "home" screen
# - I focus the "contact" screen
When(%r(^I (?:switch|focus) (?:to )?(?:the )?"([\w\s]+|%\{\w+\})" screen$)) do |*args|
  screen = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.focus(screen)
end

# Setting the current screen's width or given screen
# Examples:
# - I set the screen size to 1000x2000
# - I set the "home" screen size to 1000x2000
# - I set the screen width to 1000
# - I set the screen height to 2000
When(%r(^I set the ("([\w\s]+|%\{\w+\})")? ?screen (size|width|height) to (\d+|(\d+)x(\d+))$)) do |*args|
  _unparsed_screen, screen, dimension, size, width, height = AutomationObject::StepDefinitions::Parse.new(args).get

  screen = if screen
             AutomationObject::Framework.get.screen(screen)
           else
             AutomationObject::Framework.get.current_screen
           end

  screen.size(width.to_i, height.to_i) if width && height
  screen.width(size) if dimension == 'width' && size
  screen.height(size) if dimension == 'height' && size
end

# Test if screen is currently active
# Examples:
# - the "home" screen should be active
# - the "login" screen shouldn't be active
Then(%r(^the "([\w\s]+|%\{\w+\})" screen should ?(n't |not )?be active$)) do |*args|
  screen, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  active = AutomationObject::Framework.get.screen(screen).active?

  if negative
    expect(active).to eq(false)
  else
    expect(active).to eq(true)
  end
end