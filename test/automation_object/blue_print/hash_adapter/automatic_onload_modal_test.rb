require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal
class TestHashAdapterAutomaticOnloadModal < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::AutomaticOnloadModal
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal
  self.defaults = {
    modal_name: nil,
    number_of_checks: 1,
    close: false
  }

  create_tests

  def test_modal_name
    composite = create_composite(modal_name: 'test_modal')
    assert_equal :test_modal, composite.modal_name
  end

  def test_number_of_checks
    composite = create_composite(number_of_checks: 2)
    assert_equal 2, composite.number_of_checks
  end

  def test_close
    composite = create_composite(close: true)
    assert_equal true, composite.close
  end
end
