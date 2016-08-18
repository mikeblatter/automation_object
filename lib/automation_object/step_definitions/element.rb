require_relative 'support/cache'
require_relative 'support/parse'

# Element related step definitions
#
# Warning: Examples documentation is parsed and turned into unit tests checked the step definition regex
# This is to make sure that the examples in the docs will actually perform as indicated
# Please follow the format below
#
# Examples:
# - First example sentence
# - Second example sentence
# - Third example sentence
# When(//) do
#   # do stuff
# end

# Step to call a method on an element
#
# Examples:
# - I click on the "home_screen" "about_button" element
# - I hover over the "home_screen" "test_link" element
# - I tap on "home_screen" "logo_button" element
When(/^I (\w+|%\{[\w\d]+\}) ?(?: on| over)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  method, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.send(screen).send(element).send(method)
end

# Step to type into a field element
#
# Examples:
# - I type "blah" into the "home_screen" "text_field" element
# - I hover over the "home_screen" "test_link" element
# - I tap on "home_screen" "logo_button" element
When(/^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to)? (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  text, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.send(screen).send(element).send_keys(text)
end

# Step to scroll to an element
#
# Examples:
# - I scroll to the "home_screen" "logo_button" element
When(/^I scroll to (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  AutomationObject::Framework.get.send(screen).send(element).scroll_into_view
end

# Step to save something from an element
#
# Examples:
# - I save "text" as "unique_value" from the "home_screen" "logo_button" element
When(/^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element$/) do |*args|
  method, key, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get
  #Save value from called method/property
  value = AutomationObject::Framework.get.send(screen).send(element).send(method)
  AutomationObject::StepDefinitions::Cache.set(key, value)
end

# Step to test element exists
#
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

# Step to test element value to a given value
# If trying to carry over from any other object, use cache mechanism
#
# Examples:
# - the "home_screen" "title" element "text" should equal "Home"
# - "home_screen" "title" element "text" should not equal "About"
# - the "home_screen" "title" element "text" shouldn't equal "%{saved_value}"
Then(/^(?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(.+)"$/) do |*args|
  screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  actual_value = AutomationObject::Framework.get.send(screen).send(element).send(method)
  if negative
    refute_equal expected_value, actual_value
  else
    assert_equal expected_value, actual_value
  end
end