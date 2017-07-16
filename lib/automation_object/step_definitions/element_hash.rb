# frozen_string_literal: true
require_relative 'support/parse'
require_relative 'support/element_hash'

# Title: Element Hash Step Definitions
# Description: Provides step definitions related to element hashes

# Call an element hash method
# Examples:
# - I click on the first "home_screen" "about_button" element hash
# - I click on the first "home_screen" "menu_modal" "about_button" element hash
When(%r(^I (\w+|%\{\w+\})?(?: on| over)?(?: the| a)? (%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$)) do |*args|
  method, key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, modal, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send(method)
  end
end

# Type into element hash field
# Examples:
# - I type "blah" into the first "home_screen" "text_field" element hash
# - I type "blah" into the first "home_screen" "menu_modal" "text_field" element hash
When(%r(^I type "([\w\s]+|%\{\w+\})" in(?:to| to)? (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$)) do |*args|
  text, key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, modal, element, key, low_range, high_range
  ) do |sub_element|
    sub_element.send_keys(text)
  end
end

# Scroll element hash item(s) into focus
# Examples:
# - I scroll to the first "home_screen" "logo_button" element hash
# - I scroll to the first "home_screen" "menu_modal" "logo_button" element hash
When(%r(^I (?:scroll |focus )(?:to |through )(?:the )?(%\{\w+\}|all|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$)) do |*args|
  key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, modal, element, key, low_range, high_range, &:scroll_into_view
  )
end

# Save value from element hash for use later
# Examples:
# - I save "text" as "unique_value" from the first "home_screen" "logo_button" element hash
# - I save "text" as "unique_value" from the first "home_screen" "menu_modal" "logo_button" element hash
When(%r(^I save "(\w+|%\{\w+\})" as "(\w+)" from (?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash$)) do |*args|
  method, value_key, key, low_range, high_range, screen, modal, element = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
    screen, modal, element, key, low_range, high_range
  ) do |sub_element|
    value = sub_element.send(method)
    AutomationObject::StepDefinitions::Cache.set(value_key, value)
  end
end

# Test the element hashes size
# Examples:
# - the "home_screen" "title" element hash should be greater than 0
# - the "home_screen" "menu_modal" "title" element hash should be greater than 0
Then(%r(^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash should(n't|not)? (?:be )?(larger th[ae]n|greater th[ae]n|less th[ae]n|smaller th[ae]n|equals?) (?:to )?(\d+)$)) do |*args|
  screen, modal, element, negative, comparison, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  element_hash = AutomationObject::Framework.get.screen(screen).modal(modal).element_hash(element)
  assert element_hash.is_a?(Hash)

  if comparison =~ /larger th[ae]n|greater th[ae]n/
    if negative
      expect(expected_value).to_not be < element_hash.keys.length
    else
      expect(expected_value).to be < element_hash.keys.length
    end
  elsif comparison =~ /smaller th[ae]n|less th[ae]n/
    if negative
      expect(expected_value).to_not be > element_hash.keys.length
    else
      expect(expected_value).to be > element_hash.keys.length
    end
  elsif comparison =~ /equals?/
    if negative
      expect(expected_value).to_not eq(element_hash.keys.length)
    else
      expect(expected_value).to eq(element_hash.keys.length)
    end
  end
end

# Test if the element hash value equals a given value
# Examples:
# - the first "home_screen" "title" element hash "text" should equal "Home"
# - the first "home_screen" "menu_modal" "title" element hash "text" should equal "Home"
Then(%r(^(?:the )?(%\{\w+\}|random|last|first|(\d+)\.\.(\d+)) "(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash "(\w+|%\{\w+\})" should ?(n't |not )?equal "(\w+|%\{\w+\})"$)) do |*args|
  key, low_range, high_range, screen, modal, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  AutomationObject::StepDefinitions::ElementHash.iterate_and_do(
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

# Test if the element hash is unique
# Examples:
# - the "home_screen" "title" element hash "text" should be unique
# - the "home_screen" "menu_modal" "title" element hash "text" should be unique
Then(%r(^(?:the )?"(\w+|%\{\w+\})"\s*"?(\w+|%\{\w+\})?"?\s*"(\w+|%\{\w+\})" element hash "(\w+|%\{\w+\})" should(n't|not)? be unique$)) do |*args|
  screen, modal, element, method, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  element_hash = AutomationObject::Framework.get.screen(screen).modal(modal).element_hash(element)
  assert element_hash.is_a?(Hash)

  values = []
  element_hash.each_value do |sub_element|
    values.push(sub_element.send(method))
  end

  if negative
    expect(values.uniq).to_not eq(values)
  else
    expect(values.uniq).to eq(values)
  end
end
