require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal
class TestHashAdapterAutomaticOnloadModal < Minitest::Test
  INTERFACE_CLASS = AutomationObject::BluePrint::Composite::AutomaticOnloadModal
  ADAPTER_CLASS = AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal

  DEFAULTS = {
      :modal_name => nil,
      :number_of_checks => 1,
      :close => false
  }

  include HashAdapterBase

  def test_modal_name
    composite = create_composite({:modal_name => 'test_modal'})
    assert_equal :test_modal, composite.modal_name
  end

  def test_number_of_checks
    composite = create_composite({:number_of_checks => 2})
    assert_equal 2, composite.number_of_checks
  end

  def test_close
    composite = create_composite({:close => true})
    assert_equal true, composite.close
  end
end