require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::View
class TestHashAdapterView < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::View
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::View
  self.defaults = {}

  create_tests()
end
