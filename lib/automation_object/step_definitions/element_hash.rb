# frozen_string_literal: true
require_relative 'support/parse'
require_relative 'support/element_hash'
require_relative 'support/minitest'

# Description: Provides step definitions related to element hashes

# For: Calling an element hash method
# Examples:
# - I click on the first "home_screen" "about_button" element hash
When(%r(^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$)) do |*args|
  method, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send(method)
  end
end

# For: Typing into element hash field
# Examples:
# - I type "blah" into the first "home_screen" "text_field" element hash
When(%r(^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$)) do |*args|
  text, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send_keys(text)
  end
end

# For: Scrolling element hash item(s) into focus
# Examples:
# - I scroll to the first "home_screen" "logo_button" element hash
When(%r(^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$)) do |*args|
  key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, element, key, low_range, high_range, &:scroll_into_view
  )
end

# For: Saving value from element hash for use later
# Examples:
# - I save "text" as "unique_value" from the first "home_screen" "logo_button" element hash
When(%r(^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash$)) do |*args|
  method, value_key, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, element, key, low_range, high_range
  ) do |sub_element|
    value = sub_element.send(method)
    AutomationObject::StepDefinitions::Cache.set(value_key, value)
  end
end

# For: Testing the element hashes size
# Examples:
# - the "home_screen" "title" element hash should be greater than 0
Then(%r(^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$)) do |*args|
  screen, element, negative, comparison, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  element_hash = AutomationObject::Framework.get.send(screen).send(element)
  assert element_hash.is_a?(Hash)

  if comparison =~ /larger th[ae]n|greater th[ae]n/
    if negative
      refute expected_value < element_hash.keys.length
    else
      assert expected_value < element_hash.keys.length
    end
  elsif comparison =~ /smaller th[ae]n|less th[ae]n/
    if negative
      refute expected_value > element_hash.keys.length
    else
      assert expected_value > element_hash.keys.length
    end
  elsif comparison =~ /equals?/
    if negative
      refute_equals expected_value, element_hash.keys.length
    else
      assert_equals expected_value, element_hash.keys.length
    end
  end
end

# For: Testing if the element hash value equals a given value
# Examples:
# - the first "home_screen" "title" element hash "text" should equal "Home"
Then(%r(^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(\w+|%\{[\w\d]+\})"$)) do |*args|
  key, low_range, high_range, screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
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

# For: Testing if the element hashes uniqueness
# Examples:
# - the "home_screen" "title" element hash "text" should be unique
Then(%r(^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element hash "([\w\d]+|%\{[\w\d]+\})" should(n't|not)? be unique$)) do |*args|
  screen, element, method, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  element_hash = AutomationObject::Framework.get.send(screen).send(element)
  assert element_hash.is_a?(Hash)

  values = []
  element_hash.each_value do |sub_element|
    values.push(sub_element.send(method))
  end

  if negative
    refute_equals values.uniq, values
  else
    assert_equals values.uniq, values
  end
end
