require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::HookElementRequirements
class TestHashAdapterHookElementRequirements < Minitest::Test
  INTERFACE_CLASS = AutomationObject::BluePrint::Composite::HookElementRequirements
  ADAPTER_CLASS = AutomationObject::BluePrint::HashAdapter::HookElementRequirements

  DEFAULTS = {
      :hook_order => [:exists?],
      :element_name => nil
  }

  include HashAdapterBase

  def test_hook_order
    composite = self.create_composite({ :text => 'Text should be this', :exists? => true, :element_name => 'element_name'})
    assert_equal [:exists?, :text], composite.hook_order
  end

  def test_requirement
    composite = self.create_composite({ :text => 'Text should be this', :exists? => true, :element_name => 'element_name'})

    assert_equal 'Text should be this', composite.requirement(:text)
    assert_equal nil, composite.requirement(:nonexistent_key)
  end

  def test_element_name
    composite = self.create_composite({ :text => 'Text should be this', :exists? => true, :element_name => 'element_name'})
    assert_equal :element_name, composite.element_name
  end
end