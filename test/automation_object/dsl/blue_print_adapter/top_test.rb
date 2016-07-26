require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/blue_print_adapter/top'

#Test AutomationObject::Dsl::BluePrintAdapter::Top
class TestDslBluePrintAdapterTop < Minitest::Test
  def setup
    sub_screen_stub = stub(:modals => {}, :elements => {}, :element_arrays => {}, :element_hashes => {}, :element_groups => {})
    blue_print_stub = stub(:screens => { :test_screen_one => sub_screen_stub, :test_screen_two => sub_screen_stub })
    @top_adapter = AutomationObject::Dsl::BluePrintAdapter::Top.new(blue_prints: blue_print_stub)
  end

  def teardown
  end

  def test_implements_proxy
    proxy = @top_adapter.build
    assert_instance_of AutomationObject::Dsl::Models::Top, proxy
  end

  def test_has_many
    proxy = @top_adapter.build

    assert_respond_to proxy, :test_screen_one
    assert_respond_to proxy, :test_screen_two
  end
end