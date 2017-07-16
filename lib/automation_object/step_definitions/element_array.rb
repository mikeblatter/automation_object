# frozen_string_literal: true
require_relative 'support/parse'
require_relative 'support/element_array'

# Description: Use the following step definitions to interact with or test element arrays

# For: Call an element array method
# Examples:
# - I click on the first "home_screen" "about_button" element array
# - I hover over all "home_screen" "about_button" element array
# - I click on 0..9 "home_screen" "about_button" element array
# - I click on 0..9 "home_screen" "menu_modal" "about_button" element array
# - I click on a random "home_screen" "about_button" element array
When(%r(^I (\w+|%\{\w+\})?(?: on| over)?(?: the| a)? (%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$)) do |*args|
  method, key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, modal, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send(method)
  end
end

# For: Type into element array field
# Examples:
# - I type "blah" into the first "home_screen" "text_field" element array
# - I type "blah" into the first "home_screen" "menu_modal" "text_field" element array
When(%r(^I type "([\w\s]+|%\{\w+\})" in(?:to| to)? (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$)) do |*args|
  text, key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, modal, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send_keys(text)
  end
end

# For: Scroll element array item(s) into focus
# Examples:
# - I scroll to the first "home_screen" "logo_button" element array
# - I scroll to the first "home_screen" "menu_modal" "logo_button" element array
When(%r(^I (?:scroll |focus )(?:to |through )(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$)) do |*args|
  key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, modal, element, key, low_range, high_range, &:scroll_into_view
  )
end

# For: Save value from element array for use later
# Examples:
# - I save "text" as "unique_value" from the first "home_screen" "logo_button" element array
# - I save "text" as "unique_value" from the first "home_screen" "menu_modal" "logo_button" element array
When(%r(^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array$)) do |*args|
  method, value_key, key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, modal, element, key, low_range, high_range
  ) do |sub_element|
    value = sub_element.send(method)
    AutomationObject::StepDefinitions::Cache.set(value_key, value)
  end
end

# For: Test the element arrays length
# Examples:
# - the "home_screen" "title" element array should be greater than 0
# - the "home_screen" "menu_modal" "title" element array should be greater than 0
Then(%r(^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$)) do |*args|
  screen, modal, element, negative, comparison, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.screen(screen).modal(modal).element_array(element)
  assert element_array.is_a?(Array)

  if comparison =~ /larger th[ae]n|greater th[ae]n/
    if negative
      expect(expected_value).to_not be < element_array.length
    else
      expect(expected_value).to be < element_array.length
    end
  elsif comparison =~ /smaller th[ae]n|less th[ae]n/
    if negative
      expect(expected_value).to_not be > element_array.length
    else
      expect(expected_value).to be > element_array.length
    end
  elsif comparison =~ /equals?/
    if negative
      expect(expected_value).to_not eq(element_array.length)
    else
      expect(expected_value).to eq(element_array.length)
    end
  end
end

# For: Test if the element method value equals a given value
# Examples:
# - the first "home_screen" "title" element array "text" should equal "Home"
# - the last "home_screen" "title" element array "text" shouldn't equal "Home"
# - the random "home_screen" "title" element array "text" should not equal "Home"
# - the random "home_screen" "menu_modal" "title" element array "text" should not equal "Home"
# - the 0..9 "home_screen" "title" element array "text" should equal "Home"
# - the all "home_screen" "title" element array "text" should not equal "Home"
Then(%r(^(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array "(\w+|%\{\w+\})" should?(n't| not)? equal "(\w+|%\{\w+\})"$)) do |*args|
  key, low_range, high_range, screen, modal, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementArray.iterate_and_do(
    screen, modal, element, key, low_range, high_range
  ) do |sub_element|
    value = sub_element.send(method)

    if negative
      expect(expected_value).to_not eq(value)
    else
      expect(expected_value).to eq(value)
    end
  end
end

# For: Test if the element arrays is unique
# Examples:
# - the "home_screen" "title" element array "text" should be unique
# - the "home_screen" "title" element array "text" should not be unique
# - the "home_screen" "menu_modal" "title" element array "text" should not be unique
# - the "home_screen" "title" element array "text" shouldn't be unique
Then(%r(^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element array "(\w+|%\{\w+\})" should(n't| not)? be unique$)) do |*args|
  screen, modal, element, method, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  element_array = AutomationObject::Framework.get.screen(screen).modal(modal).element_array(element)
  assert element_array.is_a?(Array)

  values = []
  element_array.each do |sub_element|
    values.push(sub_element.send(method))
  end

  if negative
    expect(values.uniq).to_not eq(values)
  else
    expect(values.uniq).to eq(values)
  end
end
