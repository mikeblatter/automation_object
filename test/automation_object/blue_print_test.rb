# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../lib/automation_object/blue_print/hash_adapter'

# Test BluePrint Port
class TestBluePrint < Minitest::Test
  def setup
    # Reset Adapter
    AutomationObject::BluePrint.instance_variable_set(:@adapter, nil)
  end

  def teardown; end

  def test_adapter_default
    assert_equal AutomationObject::BluePrint::HashAdapter, AutomationObject::BluePrint.adapter
  end

  def test_adapter_hash
    AutomationObject::BluePrint.adapter = :hash
    assert_equal AutomationObject::BluePrint::HashAdapter, AutomationObject::BluePrint.adapter
  end

  def test_adapter_yaml
    AutomationObject::BluePrint.adapter = :yaml
    assert_equal AutomationObject::BluePrint::YamlAdapter, AutomationObject::BluePrint.adapter
  end
end
