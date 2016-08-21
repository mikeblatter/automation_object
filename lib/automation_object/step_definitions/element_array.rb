require_relative 'support/parse'
require_relative 'support/element_array'

# Element Array related step definitions
#
# Warning: Examples documentation is parsed and turned into unit tests checked the step definition regex
# This is to make sure that the examples in the docs will actually perform as indicated
# Please follow what is already defined below

# Step to call a method on an element
#
# Examples:
# - I click on the first "home_screen" "about_button" element array
# - I hover over all "home_screen" "about_button" element array
# - I click on 0..9 "home_screen" "about_button" element array
# - I click on a random "home_screen" "about_button" element array
When(/^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  method, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    element.send(method)
  end
end

# Step to type into a field element array
#
# Examples:
# - I type "blah" into the first "home_screen" "text_field" element array
When(/^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  text, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    element.send_keys(text)
  end
end

# Step to scroll to an element array
#
# Examples:
# - I scroll to the first "home_screen" "logo_button" element array
When(/^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    element.scroll_into_view
  end
end

# Step to save something from an element array
#
# Examples:
# - I save "text" as "unique_value" from the first "home_screen" "logo_button" element array
When(/^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  method, value_key, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    value = element.send(method)
    AutomationObject::StepDefinitions::Cache.set(value_key, value)
  end
end

# Step to test if element array length
#
# Examples:
# - the "home_screen" "title" element array should be greater than 0
Then(/^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$/) do |*args|
  screen, element, negative, comparison, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  case
    when comparison.match(/larger th[ae]n|greater th[ae]n/)
      if negative
        refute expected_value < element_array.length
      else
        assert expected_value < element_array.length
      end
    when comparison.match(/smaller th[ae]n|less th[ae]n/)
      if negative
        refute expected_value > element_array.length
      else
        assert expected_value > element_array.length
      end
    when comparison.match(/equals?/)
      if negative
        refute_equals expected_value, element_array.length
      else
        assert_equals expected_value, element_array.length
      end
  end
end

# Step to test element(s) of an array value to a given value
# If trying to carry over from any other object, use cache mechanism
#
# Examples:
# - the first "home_screen" "title" element array "text" should equal "Home"
# - the last "home_screen" "title" element array "text" shouldn't equal "Home"
# - the random "home_screen" "title" element array "text" should not equal "Home"
# - the 0..9 "home_screen" "title" element array "text" should equal "Home"
# - the all "home_screen" "title" element array "text" should not equal "Home"
Then(/^(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array "(\w+|%\{[\w\d]+\})" should?(n't| not)? equal "(\w+|%\{[\w\d]+\})"$/) do |*args|
  key, low_range, high_range, screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    value = element.send(method)

    if negative
      refute_equals expected_value, value
    else
      assert_equals expected_value, value
    end
  end
end

# Step to test element array element values for uniqueness
#
# Examples:
# - the "home_screen" "title" element array "text" should be unique
# - the "home_screen" "title" element array "text" should not be unique
# - the "home_screen" "title" element array "text" shouldn't be unique
Then(/^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element array "([\w\d]+|%\{[\w\d]+\})" should(n't| not)? be unique$/) do |*args|
  screen, element, method, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  values = []
  element_array.each { |element|
    values.push(element.send(method))
  }

  if negative
    refute_equals values.uniq, values
  else
    assert_equals values.uniq, values
  end
end