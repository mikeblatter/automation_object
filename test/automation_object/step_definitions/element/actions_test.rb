require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/step_definitions/element/actions'

class TestElementStepDefinitionActions < Minitest::Test
  def setup
  end

  def teardown
  end

  def test_call_action
    action = AutomationObject::StepDefinitions::Element::CallAction.new('method', 'screen', 'element')
    automatuon_object_stub = stub(:screen => stub(:element => stub(:method => 'blah')))

    #Stub and run
    action.automation_object = automatuon_object_stub
    action.run
  end

  def test_type_method
  end

  def test_scroll_method
  end

  def test_save_method
  end

  def test_exist_should
  end

  def test_equal_should
  end
end