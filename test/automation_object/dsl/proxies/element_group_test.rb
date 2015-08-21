require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/proxies/element_group'

#Test AutomationObject::Dsl::Proxies::ElementGroup
class TestDslProxyElementGroup < Minitest::Test
  def setup
    @proxy = AutomationObject::Dsl::Proxies::ElementGroup.new
  end

  def teardown
  end

  def test_subject
    assert_instance_of AutomationObject::Dsl::Models::ElementGroup, @proxy
  end
end