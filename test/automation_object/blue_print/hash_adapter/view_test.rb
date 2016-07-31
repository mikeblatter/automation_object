require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::View
class TestHashAdapterView < Minitest::Test
  INTERFACE_CLASS = AutomationObject::BluePrint::Composite::View
  ADAPTER_CLASS = AutomationObject::BluePrint::HashAdapter::View

  DEFAULTS = {
  }

  include HashAdapterBase
end