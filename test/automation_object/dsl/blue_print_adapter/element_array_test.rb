require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/blue_print_adapter/element_array'

#Test AutomationObject::Dsl::BluePrintAdapter::ElementArray
class TestDslBluePrintAdapterElementArray < Minitest::Test
  def setup
    blue_print_stub = stub()
    @element_array_adapter = AutomationObject::Dsl::BluePrintAdapter::ElementArray.new(blue_prints: blue_print_stub)
  end

  def teardown
  end

  def test_implements_proxy
    proxy = @element_array_adapter.build_composite
    assert_instance_of AutomationObject::Dsl::Models::ElementArray, proxy
  end
end