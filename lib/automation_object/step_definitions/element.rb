# frozen_string_literal: true
require_relative 'support/parse'

# Element Step Definitions
# Provides step definitions related to elements

# Call an element method
# Examples:
# - I click on the "home_screen" "about_button" element
# - I hover over the "home_screen" "test_link" element
# - I hover over the "home_screen" "menu_modal" "test_link" element
# - I tap on "home_screen" "logo_button" element
When(%r(^I (\w+|%\{\w+\}) ?(?: on| over)? (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$)) do |*args|
  method, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.screen(screen).modal(modal).element(element).send(method)
end

# Type into element field
# Examples:
# - I type "blah" into the "home_screen" "text_field" element
# - I type "test" in the "home_screen" "text_field" element
# - I type "test" in the "home_screen" "menu_modal" "text_field" element
# - I type "blah" in "home_screen" "text_field" element
When(%r(^I type "([^"]+|%\{\w+\})" in(?:to)? (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$)) do |*args|
  text, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.screen(screen).modal(modal).element(element).send_keys(text)
end

# Scroll element into focus
# Examples:
# - I scroll to the "home_screen" "logo_button" element
# - I focus to the "home_screen" "logo_button" element
# - I scroll to "home_screen" "logo_button" element
# - I scroll to "home_screen" "menu_modal" "logo_button" element
When(%r(^I (?:scroll |focus )to (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$)) do |*args|
  screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.screen(screen).modal(modal).element(element).scroll_into_view
end

# Save value from element for use later
# Examples:
# - I save "text" as "unique_value" from the "home_screen" "logo_button" element
# - I save "id" as "unique_value" from "home_screen" "logo_button" element
# - I save "id" as "unique_value" from "home_screen" "menu_modal" "logo_button" element
When(%r(^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element$)) do |*args|
  method, key, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get
  # Save value from called method/property
  value = AutomationObject::Framework.get.screen(screen).modal(modal).element(element).send(method)
  AutomationObject::StepDefinitions::Cache.set(key, value)
end

# Test if the element exists or not
# Examples:
# - the "home_screen" "title" element should exist
# - the "home_screen" "title" element shouldn't exist
# - "home_screen" "title" element should not exist
# - "home_screen" "menu_modal" "title" element should not exist
Then(%r(^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element should ?(n't |not )?exist$)) do |*args|
  screen, modal, element, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  exists = AutomationObject::Framework.get.screen(screen).modal(modal).element(element).exists?
  if negative
    expect(exists).to eq(false)
  else
    expect(exists).to eq(true)
  end
end

# Test if the element method value equals a given value
# Examples:
# - the "home_screen" "title" element "text" should equal "Home"
# - "home_screen" "title" element "text" should not equal "About"
# - "home_screen" "menu_modal" "title" element "text" should not equal "About"
# - the "home_screen" "title" element "text" shouldn't equal "%{saved_value}"
Then(%r(^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element "(\w+|%\{\w+\})" should ?(n't |not )?equal "(\w+|%\{\w+\})"$)) do |*args|
  screen, modal, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  actual_value = AutomationObject::Framework.get.screen(screen).modal(modal).element(element).send(method)
  if negative
    expect(expected_value).not_to eq(actual_value)
  else
    expect(expected_value).to eq(actual_value)
  end
end
