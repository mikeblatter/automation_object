require_relative '../../test_helper'

#Test AutomationObject::BluePrint::HashAdapter
class TestBluePrintHashAdapter < Minitest::Test
  def setup
    AutomationObject::BluePrint.adapter = :hash
    AutomationObject::BluePrint::HashAdapter::Top.skip_validations = true

    @hash_adapter = AutomationObject::BluePrint::HashAdapter.build_composite
  end

  def teardown
    AutomationObject::BluePrint.adapter = :hash
    AutomationObject::BluePrint::HashAdapter::Top.skip_validations = false
  end

  def test_new
    assert_instance_of AutomationObject::BluePrint::HashAdapter::Top, @hash_adapter
  end
end