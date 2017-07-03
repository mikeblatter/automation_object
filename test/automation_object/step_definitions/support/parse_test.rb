# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/step_definitions/support/parse'

class TestStepDefinitionsSupportParse < Minitest::Test
  def setup; end

  def teardown
    AutomationObject::StepDefinitions::Cache.instance_variable_set(:@values, {})
  end

  def test_get
    AutomationObject::StepDefinitions::Cache.set('test_key', 'test_get')

    args = ['plain', '%{test_key}']
    parsed_args = AutomationObject::StepDefinitions::Parse.new(args).get

    assert_equal %w[plain test_get], parsed_args
  end

  def test_parse
    AutomationObject::StepDefinitions::Cache.set('test_key', 'test_parse')

    parse = AutomationObject::StepDefinitions::Parse.new({})
    parsed_string = parse.send(:parse, '%{test_key}')

    assert_equal 'test_parse', parsed_string
  end

  def test_parse_nil
    parse = AutomationObject::StepDefinitions::Parse.new({})
    parsed_string = parse.send(:parse, nil)

    assert_nil parsed_string
  end
end
