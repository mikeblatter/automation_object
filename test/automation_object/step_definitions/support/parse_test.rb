require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/step_definitions/support/parse'

class TestStepDefinitionsSupportParse < Minitest::Test
  def setup
  end

  def teardown
    AutomationObject::StepDefinitions::Cache.instance_variable_set(:@values, {})
  end

  def test_get
    AutomationObject::StepDefinitions::Cache.set('test_key', 'test')

    args = ['plain', '%{test_key}']
    parsed_args = AutomationObject::StepDefinitions::Parse.new(args).get

    assert_equal ['plain', 'test'], parsed_args
  end
end