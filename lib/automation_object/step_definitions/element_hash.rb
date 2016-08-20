require_relative 'support/cache'
require_relative 'support/parse'

require_relative 'support/element_hash'

# Element Array related step definitions
#
# Warning: Examples documentation is parsed and turned into unit tests checked the step definition regex
# This is to make sure that the examples in the docs will actually perform as indicated
# Please follow what is already defined below

# Step to call a method on an element
#
# Examples:
# - I click on the first "home_screen" "about_button" element hash
When(/^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash/) do |*args|
  method, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    element.send(method)
  end
end

# Step to type into a field element array
#
# Examples:
# - I type "blah" into the first "home_screen" "text_field" element hash
When(/^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash/) do |*args|
  text, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    element.send_keys(text)
  end
end

# Step to scroll to an element array
#
# Examples:
# - I scroll to the first "home_screen" "logo_button" element hash
When(/^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash/) do |*args|
  key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    element.scroll_into_view
  end
end

# Step to save something from an element array
#
# Examples:
# - I save "text" as "unique_value" from the first "home_screen" "logo_button" element hash
When(/^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash/) do |*args|
  method, value_key, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
      screen, element, key, low_range, high_range) do |element|
    value = element.send(method)
    AutomationObject::StepDefinitions::Cache.set(value_key, value)
  end
end

# Step to test if element array length
#
# Examples:
# - the "home_screen" "title" element hash should be greater than 0
Then(/^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$/) do |*args|
  screen, element, negative, comparison, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  element_hash = AutomationObject::Framework.get.send(screen).send(element)
  assert element_hash.is_a?(Hash)

  case
    when comparison.match(/larger th[ae]n|greater th[ae]n/)
      if negative
        refute expected_value < element_hash.keys.length
      else
        assert expected_value < element_hash.keys.length
      end
    when comparison.match(/smaller th[ae]n|less th[ae]n/)
      if negative
        refute expected_value > element_hash.keys.length
      else
        assert expected_value > element_hash.keys.length
      end
    when comparison.match(/equals?/)
      if negative
        refute_equals expected_value, element_hash.keys.length
      else
        assert_equals expected_value, element_hash.keys.length
      end
  end
end

# Step to test element(s) of an array value to a given value
# If trying to carry over from any other object, use cache mechanism
#
# Examples:
# - the first "home_screen" "title" element hash "text" should equal "Home"
Then(/^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element hash "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(\w+|%\{[\w\d]+\})"$/) do |*args|
  key, low_range, high_range, screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
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
# - the "home_screen" "title" element hash "text" should be unique
Then(/^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element hash "([\w\d]+|%\{[\w\d]+\})" should(n't|not)? be unique$/) do |*args|
  screen, element, method, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  element_hash = AutomationObject::Framework.get.send(screen).send(element)
  assert element_hash.is_a?(Hash)

  values = []
  element_hash.each_value { |element|
    values.push(element.send(method))
  }

  if negative
    refute_equals values.uniq, values
  else
    assert_equals values.uniq, values
  end
end