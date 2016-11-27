# frozen_string_literal: true
require_relative 'support/parse'
require_relative 'support/minitest'

# Description: Provides step definitions related to modals

# For: Test if modal is currently active
# Examples:
# - the "home_screen" "test_modal" modal should be active
# - the "login_screen" "test_modal" modal shouldn't be active
Then(%r(^the "([\w\s]+|%\{[\w\d]+\})" "([\w\s]+|%\{[\w\d]+\})" modal should ?(n't |not )?be active$)) do |*args|
  screen, modal, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  if negative
    assert_equal false, AutomationObject::Framework.get.send(screen).send(modal).active?
  else
    assert_equal true, AutomationObject::Framework.get.send(screen).send(modal).active?
  end
end