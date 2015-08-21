require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/blue_print_adapter/modal'

#Test AutomationObject::Dsl::BluePrintAdapter::Modal
class TestDslBluePrintAdapterModal < Minitest::Test
  def setup
    blue_print_stub = stub(
        :elements => {
            :test_element => stub()
        },
        :element_arrays => {
            :test_element_array => stub()
        },
        :element_groups => {
            :test_element_group => stub()
        },
        :element_hashes => {
            :test_element_hash => stub()
        }
    )
    @modal_adapter = AutomationObject::Dsl::BluePrintAdapter::Modal.new(blue_prints: blue_print_stub)
  end

  def teardown
  end

  def test_implements_proxy
    proxy = @modal_adapter.build_composite
    assert_instance_of AutomationObject::Dsl::Models::Modal, proxy
  end

  def test_has_many
    proxy = @modal_adapter.build_composite

    assert_respond_to proxy, :test_element
    assert_respond_to proxy, :test_element_array
    assert_respond_to proxy, :test_element_group
    assert_respond_to proxy, :test_element_hash
  end
end