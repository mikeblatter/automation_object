require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/proxies/modal'

#Test AutomationObject::Dsl::Proxies::Modal
class TestDslProxyModal < Minitest::Test
  def setup
    @proxy = AutomationObject::Dsl::Proxies::Modal.new
  end

  def teardown
  end

  def test_subject
    assert_instance_of AutomationObject::Dsl::Models::Modal, @proxy
  end

  def test_add
    test_child_stub = stub(:test_value => 'blah')
    @proxy.add(name: :test_child, object: test_child_stub, type: :test)

    assert_respond_to @proxy, :test_child
    assert_equal test_child_stub, @proxy.test_child
    assert_equal test_child_stub, @proxy[:test_child]
  end
end