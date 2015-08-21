require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/proxies/element'

#Test AutomationObject::Dsl::Proxies::Element
class TestDslProxyElement < Minitest::Test
  def setup
    @proxy = AutomationObject::Dsl::Proxies::Element.new
  end

  def teardown
  end

  def test_subject
    assert_instance_of AutomationObject::Dsl::Models::Element, @proxy
  end
end