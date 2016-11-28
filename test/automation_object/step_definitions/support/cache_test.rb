require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/step_definitions/support/cache'

class TestStepDefinitionsSupportCache < Minitest::Test
  def setup
  end

  def teardown
    AutomationObject::StepDefinitions::Cache.instance_variable_set(:@values, {})
  end

  def test_default_values
    expected = {}
    assert_equal expected, AutomationObject::StepDefinitions::Cache.values
  end

  def test_get
    AutomationObject::StepDefinitions::Cache.instance_variable_set(:@values, { :test => 'test' })
    assert_equal 'test', AutomationObject::StepDefinitions::Cache.get(:test)
  end

  def test_set
    AutomationObject::StepDefinitions::Cache.set(:test, 'test')
    assert_equal 'test', AutomationObject::StepDefinitions::Cache.get(:test)
  end
end
