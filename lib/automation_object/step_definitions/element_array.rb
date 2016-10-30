# frozen_string_literal: true
require_relative 'support/parse'
require_relative 'support/element_array'

# Description: Provides step definitions related to element arrays

# For: Calling an element array method
# Examples:
# - I click on the first "home_screen" "about_button" element array
# - I hover over all "home_screen" "about_button" element array
# - I click on 0..9 "home_screen" "about_button" element array
# - I click on a random "home_screen" "about_button" element array
When(%r(^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/)) do |*args|
  method, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send(method)
  end
end

# For: Typing into element array field
# Examples:
# - I type "blah" into the first "home_screen" "text_field" element array
When(%r(^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/)) do |*args|
  text, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send_keys(text)
  end
end

# For: Scrolling element array item(s) into focus
# Examples:
# - I scroll to the first "home_screen" "logo_button" element array
When(%r(^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/)) do |*args|
  key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, element, key, low_range, high_range, &:scroll_into_view
  )
end

# For: Saving value from element array for use later
# Examples:
# - I save "text" as "unique_value" from the first "home_screen" "logo_button" element array
When(%r(^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/)) do |*args|
  method, value_key, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, element, key, low_range, high_range
  ) do |sub_element|
    value = sub_element.send(method)
    AutomationObject::StepDefinitions::Cache.set(value_key, value)
  end
end

# For: Testing the element arrays size
# Examples:
# - the "home_screen" "title" element array should be greater than 0
Then(%r(^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$/)) do |*args|
  screen, element, negative, comparison, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  if comparison =~ /larger th[ae]n|greater th[ae]n/
    if negative
      refute expected_value < element_array.length
    else
      assert expected_value < element_array.length
    end
  elsif comparison =~ /smaller th[ae]n|less th[ae]n/
    if negative
      refute expected_value > element_array.length
    else
      assert expected_value > element_array.length
    end
  elsif comparison =~ /equals?/
    if negative
      refute_equals expected_value, element_array.length
    else
      assert_equals expected_value, element_array.length
    end
  end
end

# For: Testing if the element method value equals a given value
# Examples:
# - the first "home_screen" "title" element array "text" should equal "Home"
# - the last "home_screen" "title" element array "text" shouldn't equal "Home"
# - the random "home_screen" "title" element array "text" should not equal "Home"
# - the 0..9 "home_screen" "title" element array "text" should equal "Home"
# - the all "home_screen" "title" element array "text" should not equal "Home"
Then(%r(^(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array "(\w+|%\{[\w\d]+\})" should?(n't| not)? equal "(\w+|%\{[\w\d]+\})"$/)) do |*args|
  key, low_range, high_range, screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, element, key, low_range, high_range
  ) do |sub_element|
    value = sub_element.send(method)

    if negative
      refute_equals expected_value, value
    else
      assert_equals expected_value, value
    end
  end
end

# For: Testing if the element arrays uniqueness
# Examples:
# - the "home_screen" "title" element array "text" should be unique
# - the "home_screen" "title" element array "text" should not be unique
# - the "home_screen" "title" element array "text" shouldn't be unique
Then(%r(^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element array "([\w\d]+|%\{[\w\d]+\})" should(n't| not)? be unique$/)) do |*args|
  screen, element, method, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  values = []
  element_array.each do |sub_element|
    values.push(sub_element.send(method))
  end

  if negative
    refute_equals values.uniq, values
  else
    assert_equals values.uniq, values
  end
end
