require_relative '../test_helper'

#Test Framework class
class TestDsl < Minitest::Test
  def setup
    #Reset Adapter
    AutomationObject::Dsl.instance_variable_set(:@adapter, nil)
  end

  def teardown
  end

  def test_adapter_default
    assert_equal AutomationObject::Dsl::BluePrintAdapter, AutomationObject::Dsl.adapter
  end

  def test_adapter_hash
    AutomationObject::Dsl.adapter = :blue_print
    assert_equal AutomationObject::Dsl::BluePrintAdapter, AutomationObject::Dsl.adapter
  end
end