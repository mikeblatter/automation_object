require_relative '../../../../test_helper'
require_relative '../../../../../lib/automation_object/blue_print/hash_adapter/helpers/hook_helper'

#Test AutomationObject::BluePrint::HashAdapter::HookHelper
class TestBluePrintHashAdapterHookHelper < Minitest::Test
  def setup
    @composite_stub = stub(:test_method => true) #Use test method to make sure hooks are called
    @composite_stub.class.send(:include, AutomationObject::BluePrint::HashAdapter::HookHelper)
  end

  def teardown
    @composite_stub.class.instance_variable_set(:@before_create_hooks, nil)
    @composite_stub.class.instance_variable_set(:@after_create_hooks, nil)
  end

  def test_before_create_run
    @composite_stub.class.before_create(:test_method)
    @composite_stub.expects(:test_method)

    @composite_stub.before_create_run
  end

  def test_after_create_run
    @composite_stub.class.after_create(:test_method)
    @composite_stub.expects(:test_method)

    @composite_stub.after_create_run
  end

  def test_before_create
    @composite_stub.class.before_create(:test_method)

    assert_instance_of Array, @composite_stub.class.before_create_hooks
    refute_empty @composite_stub.class.before_create_hooks
    assert_equal [:test_method], @composite_stub.class.before_create_hooks
  end

  def test_before_create_hooks
    assert_instance_of Array, @composite_stub.class.before_create_hooks
    assert_empty @composite_stub.class.before_create_hooks
  end

  def test_after_create
    @composite_stub.class.after_create(:test_method)

    assert_instance_of Array, @composite_stub.class.after_create_hooks
    refute_empty @composite_stub.class.after_create_hooks
    assert_equal [:test_method], @composite_stub.class.after_create_hooks
  end

  def test_after_create_hooks
    assert_instance_of Array, @composite_stub.class.after_create_hooks
    assert_empty @composite_stub.class.after_create_hooks
  end
end