require_relative 'regex'
require_relative 'actions'

# Element related step definitions

# Step to call a method on an element
#
# Examples:
# I click on the "home_screen" "about_button" element
# I hover over the "home_screen" "test_link" element
# I tap on "home_screen" "logo_button" element

When(AutomationObject::StepDefinitions::Element::CALL_REGEX) do |*args|
  AutomationObject::StepDefinitions::Element::CallAction.new(args).run
end

# Step to type into a field element
#
# Examples:
# I type "blah" into the "home_screen" "text_field" element
# I hover over the "home_screen" "test_link" element
# I tap on "home_screen" "logo_button" element

When(AutomationObject::StepDefinitions::Element::TYPE_REGEX) do |*args|
  AutomationObject::StepDefinitions::Element::TypeAction.new(args).run
end

# Step to scroll to an element
#
# Examples:
# I scroll to the "home_screen" "logo_button" element

When(AutomationObject::StepDefinitions::Element::SCROLL_REGEX) do |*args|
  AutomationObject::StepDefinitions::Element::ScrollAction.new(args).run
end

# Step to save something from an element
#
# Examples:
# I save "text" as "unique_value" from the "home_screen" "logo_button" element

When(AutomationObject::StepDefinitions::Element::SAVE_REGEX) do |*args|
  AutomationObject::StepDefinitions::Element::SaveAction.new(args).run
end

# Step to test element exists
#
# Examples:
# Then the "home_screen" "title" element should exist
# Then the "home_screen" "title" element shouldn't exist
# Then "home_screen" "title" element should not exist

Then(AutomationObject::StepDefinitions::Element::EXIST_REGEX) do |*args|
  AutomationObject::StepDefinitions::Element::ExistAction.new(args).run
end

# Step to test element value to a given value
# If trying to carry over from any other object, use cache mechanism
#
# Examples:
# the "home_screen" "title" element "text" should equal "Home"
# "home_screen" "title" element "text" should not equal "About"
# the "home_screen" "title" element "text" shouldn't equal "%{saved_value}"

Then(AutomationObject::StepDefinitions::Element::EQUAL_REGEX) do |*args|
  AutomationObject::StepDefinitions::Element::EqualAction.new(args).run
end