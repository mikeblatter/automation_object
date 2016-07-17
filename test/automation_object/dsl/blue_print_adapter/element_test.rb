require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/blue_print_adapter/element'

#Test AutomationObject::Dsl::BluePrintAdapter::Element
class TestDslBluePrintAdapterElement < Minitest::Test
  def setup
    blue_print_stub = stub()
    @element_adapter = AutomationObject::Dsl::BluePrintAdapter::Element.new(blue_prints: blue_print_stub)
  end

  def teardown
  end

  def test_implements_proxy
    proxy = @element_adapter.build_composite
<<<<<<< HEAD
    assert_instance_of AutomationObject::Dsl::Models::Element, proxy
=======
    assert_nil proxy
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
  end
end