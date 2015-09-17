require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/models/modal'

#Test AutomationObject::Dsl::Models::Modal
class TestDslModelModal < Minitest::Test
  def setup
  end

  #Make sure I can add properties on the fly to this class using OpenStruct
  def test_composite
    model = AutomationObject::Dsl::Models::Modal.new
    model.test_value = 'test'

    assert_equal 'test', model.test_value
    assert_equal 'test', model[:test_value]
  end

  def teardown
  end
end