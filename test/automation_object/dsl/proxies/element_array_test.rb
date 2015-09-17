require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/proxies/element_array'

#Test AutomationObject::Dsl::Proxies::ElementArray
class TestDslProxyElementArray < Minitest::Test
  def setup
    @proxy = AutomationObject::Dsl::Proxies::ElementArray.new
  end

  def teardown
  end

  def test_subject
    assert_instance_of AutomationObject::Dsl::Models::ElementArray, @proxy
  end
end