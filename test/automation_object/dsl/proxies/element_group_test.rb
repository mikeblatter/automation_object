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
<<<<<<< HEAD
    assert_instance_of AutomationObject::Dsl::Models::ElementGroup, @proxy
=======
    assert_nil @proxy
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
  end
end