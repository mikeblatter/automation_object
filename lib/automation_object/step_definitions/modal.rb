# frozen_string_literal: true
require_relative 'support/parse'

# Description: Provides step definitions related to modals

# For: Test if modal is currently active
# Examples:
# - the "home_screen" "test_modal" modal should be active
# - the "login_screen" "test_modal" modal shouldn't be active
Then(%r(^the "([\w\s]+|%\{\w+\})" "([\w\s]+|%\{\w+\})" modal should ?(n't |not )?be active$)) do |*args|
  screen, modal, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  active = AutomationObject::Framework.get.screen(screen).modal(modal).active?

  if negative
    expect(active).to eq(false)
  else
    expect(active).to eq(true)
  end
end