require_relative '../../../../test_helper'
require_relative '../../../../../lib/automation_object/dsl/proxies/helpers/composite_helper'

#Test AutomationObject::Dsl::Proxies::CompositeHelper
class TestDslProxyCompositeHelper < Minitest::Test
  def setup
  end

  def teardown
  end

  def create_proxy_stub
    proxy_stub = stub()
    proxy_stub.instance_variable_set(:@subject, OpenStruct.new)
    proxy_stub.extend(AutomationObject::Dsl::Proxies::CompositeHelper)

    return proxy_stub
  end

  def add_child_proxy_stub(proxy_stub, name)
    child_proxy_stub = self.create_proxy_stub
    proxy_stub.add(name: name, object: child_proxy_stub, type: :none)
    return proxy_stub
  end

  #State should pass object to children
  def test_state
    state_object = Object.new

    proxy_stub = self.create_proxy_stub
    proxy_stub = self.add_child_proxy_stub(proxy_stub, :test_child)

    proxy_stub.instance_variable_get(:@subject).test_child.expects(:state=)
    proxy_stub.state = state_object
  end

  def test_hooks_default
    proxy_stub = self.create_proxy_stub
    assert_equal Array.new, proxy_stub.hooks
  end

  def test_composite_hooks_default
    proxy_stub = self.create_proxy_stub
    assert_equal Hash.new, proxy_stub.composite_hooks
  end

  def test_children_default
    proxy_stub = self.create_proxy_stub
    assert_equal Array.new, proxy_stub.children
  end
end