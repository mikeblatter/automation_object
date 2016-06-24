require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/blue_print_adapter/element_group'

#Test AutomationObject::Dsl::BluePrintAdapter::ElementGroup
class TestDslBluePrintAdapterElementGroup < Minitest::Test
  def setup
    blue_print_stub = stub()
    @element_group_adapter = AutomationObject::Dsl::BluePrintAdapter::ElementGroup.new(blue_prints: blue_print_stub)
  end

  def teardown
  end

  def test_implements_proxy
    proxy = @element_group_adapter.build_composite
    assert_nil proxy
  end
end