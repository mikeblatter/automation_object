require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/dsl/proxies/element_hash'

#Test AutomationObject::Dsl::Proxies::ElementHash
class TestDslProxyElementHash < Minitest::Test
  def setup
    @proxy = AutomationObject::Dsl::Proxies::ElementHash.new
  end

  def teardown
  end

  def test_subject
    assert_nil @proxy
  end
end