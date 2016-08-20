# Element Hash related step definitions
#
# Warning: Examples documentation is parsed and turned into unit tests checked the step definition regex
# This is to make sure that the examples in the docs will actually perform as indicated
# Please follow what is already defined below

# Step to call a method on an element
#
# Examples:
# - I click on the "home_screen" "about_button" element
When(/^I (\w+|%\{[\w\d]+\})?(?: on| over)?(?: the| a)? (%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  method, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  case
    when low_range and high_range
      for i in low_range.to_i..high_range.to_i
        assert element_array.length > i
        element_array[i].send(method)
      end
    when key == 'all'
      for element in element_array
        element.send(method)
      end
    when key == 'random'
      element_array[rand(0..(element_array.length - 1))].send(method)
    when key == 'first'
      element_array[0].send(method)
    when key == 'last'
      element_array[element_array.length - 1].send(method)
    else
      element_array[key.to_i].send(method)
  end
end

# Step to type into a field element array
#
# Examples:
# - I type "blah" into the "home_screen" "text_field" element
When(/^I type "([\w\s]+|%\{[\w\d]+\})" in(?:to| to)? (?:the )?(%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  text, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  case
    when low_range and high_range
      for i in low_range.to_i..high_range.to_i
        assert element_array.length > i
        element_array[i].send_keys(text)
      end
    when key == 'random'
      element_array[rand(0..(element_array.length - 1))].send_keys(text)
    when key == 'first'
      element_array[0].send_keys(text)
    when key == 'last'
      element_array[element_array.length - 1].send_keys(text)
    else
      element_array[key.to_i].send_keys(text)
  end
end

# Step to scroll to an element array
#
# Examples:
# - I scroll to the "home_screen" "logo_button" element
When(/^I (?:scroll |focus )(?:to |through )(?:the )?(%\{[\w\d]+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  case
    when low_range and high_range
      for i in low_range.to_i..high_range.to_i
        assert element_array.length > i
        element_array[i].scroll_into_view
      end
    when key == 'random'
      element_array[rand(0..(element_array.length - 1))].scroll_into_view
    when key == 'first'
      element_array[0].scroll_into_view
    when key == 'last'
      element_array[element_array.length - 1].scroll_into_view
    else
      element_array[key.to_i].scroll_into_view
  end
end

# Step to save something from an element array
#
# Examples:
# - I save "text" as "unique_value" from the "home_screen" "logo_button" element
When(/^I save "(\w+|%\{[\w\d]+\})" as "([\w\d]+)" from (%\{[\w\d]+\}|random|last|first|(\d+)\.\.(\d+)) (?:the )?"(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array$/) do |*args|
  method, value_key, key, low_range, high_range, screen, element = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  case
    when low_range and high_range
      for i in low_range.to_i..high_range.to_i
        assert element_array.length > i

        value = element_array[i].send(method)
        AutomationObject::StepDefinitions::Cache.set(value_key, value)
      end
    when key == 'random'
      value = element_array[rand(0..(element_array.length - 1))].send(method)
      AutomationObject::StepDefinitions::Cache.set(value_key, value)
    when key == 'first'
      value = element_array[0].send(method)
      AutomationObject::StepDefinitions::Cache.set(value_key, value)
    when key == 'last'
      value = element_array[element_array.length - 1].send(method)
      AutomationObject::StepDefinitions::Cache.set(value_key, value)
    else
      value = element_array[key.to_i].send(method)
      AutomationObject::StepDefinitions::Cache.set(value_key, value)
  end
end

# Step to test if element array length
#
# Examples:
# - the "home_screen" "title" element should exist
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
# - the "home_screen" "title" element "text" should equal "Home"
Then(/^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{[\w\d]+\})" "(\w+|%\{[\w\d]+\})" element array "(\w+|%\{[\w\d]+\})" should ?(n't |not )?equal "(\w+|%\{[\w\d]+\})"$/) do |*args|
  key, low_range, high_range, screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.send(screen).send(element)
  assert element_array.is_a?(Array)

  case
    when low_range and high_range
      for i in low_range.to_i..high_range.to_i
        assert element_array.length > i

        value = element_array[i].send(method)
        assert_equals expected_value, value
      end
    when key == 'random'
      value = element_array[rand(0..(element_array.length - 1))].send(method)
      assert_equals expected_value, value
    when key == 'first'
      value = element_array[0].send(method)
      assert_equals expected_value, value
    when key == 'last'
      value = element_array[element_array.length - 1].send(method)
      assert_equals expected_value, value
    else
      value = element_array[key.to_i].send(method)
      assert_equals expected_value, value
  end
end

# Step to test element array element values for uniqueness
#
# Examples:
# - the "home_screen" "title" element "text" should equal "Home"
Then(/^(?:the )?"([\w\d]+|%\{[\w\d]+\})" "([\w\d]+|%\{[\w\d]+\})" element array "([\w\d]+|%\{[\w\d]+\})" should(n't|not)? be unique$/) do |*args|
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