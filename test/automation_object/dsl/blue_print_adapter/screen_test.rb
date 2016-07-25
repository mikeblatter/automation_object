require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/blue_print_adapter/screen'

#Test AutomationObject::Dsl::BluePrintAdapter::Screen
class TestDslBluePrintAdapterScreen < Minitest::Test
  def setup
    blue_print_stub = stub(
        :modals => {
            :test_modal => stub(:elements => {}, :element_arrays => {}, :element_groups => {}, :element_hashes => {})
        },
        :elements => {
            :test_element => stub()
        },
        :element_arrays => {
            :test_element_array => stub()
        },
        :element_hashes => {
            :test_element_hash => stub()
        }
    )
    @screen_adapter = AutomationObject::Dsl::BluePrintAdapter::Screen.new(blue_prints: blue_print_stub)
  end

  def teardown
  end

  def test_implements_proxy
    proxy = @screen_adapter.build_composite
    assert_instance_of AutomationObject::Dsl::Models::Screen, proxy
  end

  def test_has_many
    proxy = @screen_adapter.build_composite

    assert_respond_to proxy, :test_modal
    assert_respond_to proxy, :test_element
    assert_respond_to proxy, :test_element_array
    assert_respond_to proxy, :test_element_hash
  end
end