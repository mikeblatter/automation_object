require_relative 'regex'

# Test element exists

# Examples:
# Then the "home_screen" "title" element should exist
# Then the "home_screen" "title" element shouldn't exist
# Then "home_screen" "title" element should not exist

Then(AutomationObject::StepDefinitions::Element::Regex::EXIST_SHOULD) do |*args|
  #Parse args for any stored cache values
  screen, element, negative = AutomationObject::StepDefinitions::Parse.new(args).get

  exists = AutomationObject::Framework.get.send(screen).send(element).exists?

  if negative
    assert_equal false, exists
  else
    assert_equal true, exists
  end
end

# Test element value to a given value
# If trying to carry over from any other object, use cache mechanism

# Examples:
# Then the "home_screen" "title" element "text" should equal "Home"
# Then "home_screen" "title" element "text" should not equal "About"
# Then the "home_screen" "title" element "text" shouldn't equal "%{saved_value}"

Then(AutomationObject::StepDefinitions::Element::Regex::EQUAL_SHOULD) do |*args|
  #Parse args for any stored cache values
  screen, element, method, negative, expected_value = AutomationObject::StepDefinitions::Parse.new(args).get

  actual_value = AutomationObject::Framework.get.send(screen).send(element).send(method)

  if negative
    refute_equal expected_value, actual_value
  else
    assert_equal expected_value, actual_value
  end
end




