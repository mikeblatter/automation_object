# frozen_string_literal: true

require_relative 'support/parse'

# Description: Use the following step definitions to interact with or test modals

# Automatically navigate to the modal
# Examples:
# - I go to the "home_screen" "test_modal" modal
# - I go to "login_screen" "test_modal" modal
When(/^I go to (?:the |)"([\w\s]+|%\{\w+\})" "([\w\s]+|%\{\w+\})" modal$/) do |*args|
  screen, modal = AutomationObject::StepDefinitions::Parse.new(args).get

  success = AutomationObject::Framework.get.screen(screen).modal(modal).go
  expect(success).to eq(true)
end

# Test if modal is currently active
# Examples:
# - the "home_screen" "test_modal" modal should be active
# - the "login_screen" "test_modal" modal shouldn't be active
Then(/^the "([\w\s]+|%\{\w+\})" "([\w\s]+|%\{\w+\})" modal should ?(n't |not )?be active$/) do |*args|
  screen, modal, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  active = AutomationObject::Framework.get.screen(screen).modal(modal).active?

  if negative
    expect(active).to eq(false)
  else
    expect(active).to eq(true)
  end
end
