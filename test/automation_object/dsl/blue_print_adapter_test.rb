require_relative '../../test_helper'
require_relative '../../../lib/automation_object/dsl/blue_print_adapter'

#Test AutomationObject::Dsl::BluePrintAdapter
class TestDslBluePrintAdapter < Minitest::Test
  def setup
  end

  def teardown
  end

  def test_build_composite_error
    assert_raises KeyError do
      AutomationObject::Dsl::BluePrintAdapter.build
    end
  end

  def test_build_composite
    blue_print_stub = stub(:screens => {})
    assert_instance_of AutomationObject::Dsl::Models::Top,
                       AutomationObject::Dsl::BluePrintAdapter.build(blue_prints: blue_print_stub)
  end
end