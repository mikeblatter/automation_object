# frozen_string_literal: true
require_relative 'support/parse'

# Description: Provides step definitions related to elements

# For: Calling an element method
# Examples:
# - I click on the "home_screen" "about_button" element
# - I hover over the "home_screen" "test_link" element
# - I tap on "home_screen" "logo_button" element
When(/^I (\w+|%\{[\w\d]+\}) ?(?: on| over)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  method, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.send(screen).send(element).send(method)
end

# For: Typing into element field
# Examples:
# - I type "blah" into the "home_screen" "text_field" element
# - I type "test" in the "home_screen" "text_field" element
# - I type "blah" in "home_screen" "text_field" element
When(/^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  text, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.send(screen).send(element).send_keys(text)
end

# For: Scrolling element into focus
# Examples:
# - I scroll to the "home_screen" "logo_button" element
# - I focus to the "home_screen" "logo_button" element
# - I scroll to "home_screen" "logo_button" element
When(/^I (?:scroll |focus )to (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.send(screen).send(element).scroll_into_view
end

# For: Saving value from element for use later
# Examples:
# - I save "text" as "unique_value" from the "home_screen" "logo_button" element
# - I save "id" as "unique_value" from "home_screen" "logo_button" element
When(/^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  method, key, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  # Save value from called method/property
  value = AutomationObject::Framework.get.send(screen).send(element).send(method)
  AutomationObject::StepDefinitions::Cache.set(key, value)
end

# For: Testing if the element exists or not
# Examples:
# - the "home_screen" "title" element should exist
# - the "home_screen" "title" element shouldn't exist
# - "home_screen" "title" element should not exist
Then(/^(?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element should ?(n't |not )?exist$/) do |*args|
  screen, element, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  exists = AutomationObject::Framework.get.send(screen).send(element).exists?
  if negative
    assert_equal false, exists
  else
    assert_equal true, exists
  end
end

# For: Testing if the element method value equals a given value
# Examples:
# - the "home_screen" "title" element "text" should equal "Home"
# - "home_screen" "title" element "text" should not equal "About"
# - the "home_screen" "title" element "text" shouldn't equal "%{saved_value}"
Then(/^(?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(\w+|%\{[\w\d]+\})"$/) do |*args|
  screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  actual_value = AutomationObject::Framework.get.send(screen).send(element).send(method)
  if negative
    refute_equal expected_value, actual_value
  else
    assert_equal expected_value, actual_value
  end
end
