require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/step_definitions/element/regex'

class TestElementStepDefinitionRegex < Minitest::Test
  CALL_EXAMPLES = [
      'I click on the "home_screen" "about_button" element',
      'I hover over the "home_screen" "test_link" element',
      'I tap on "home_screen" "logo_button" element'
  ]

  TYPE_EXAMPLES = [
      'I type "blah" into the "home_screen" "text_field" element'
  ]

  SCROLL_EXAMPLES = [
      'I scroll to the "home_screen" "about_button" element'
  ]

  SAVE_EXAMPLES = [
      'I save "text" as "something_unique" from the "home_screen" "title" element'
  ]

  EXIST_EXAMPLES = [
      'the "home_screen" "test" element should not exist'
  ]

  EQUAL_EXAMPLES = [
      'the "home_screen" "title" element "text" should equal "Home"',
      '"home_screen" "title" element "text" should not equal "About"',
      'the "home_screen" "title" element "text" shouldn\'t equal "%{saved_value}"',
      'the "home_screen" "test" element "text" should not equal "blah"',
  ]

  def setup
  end

  def teardown
  end

  def test_call_method
    iterate_and_test(CALL_EXAMPLES, AutomationObject::StepDefinitions::Element::CALL_REGEX)
  end

  def test_type_method
    iterate_and_test(TYPE_EXAMPLES, AutomationObject::StepDefinitions::Element::TYPE_REGEX)
  end

  def test_scroll_method
    iterate_and_test(SCROLL_EXAMPLES, AutomationObject::StepDefinitions::Element::SCROLL_REGEX)
  end

  def test_save_method
    iterate_and_test(SAVE_EXAMPLES, AutomationObject::StepDefinitions::Element::SAVE_REGEX)
  end

  def test_exist_should
    iterate_and_test(EXIST_EXAMPLES, AutomationObject::StepDefinitions::Element::EXIST_REGEX)
  end

  def test_equal_should
    iterate_and_test(EQUAL_EXAMPLES, AutomationObject::StepDefinitions::Element::EQUAL_REGEX)
  end

  #Iterate through examples and make sure there is a match
  #Then iterate through the rest of the examples to make sure they don't match
  def iterate_and_test(examples, regex)
    for example in examples
      refute_nil example.match(regex)
    end

    all_examples = CALL_EXAMPLES + TYPE_EXAMPLES + SCROLL_EXAMPLES + SAVE_EXAMPLES + EXIST_EXAMPLES + EQUAL_EXAMPLES - examples

    for bad_example in all_examples
      assert_nil bad_example.match(regex)
    end
  end
end