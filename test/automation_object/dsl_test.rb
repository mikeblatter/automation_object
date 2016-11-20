# frozen_string_literal: true
require_relative '../test_helper'

# Test Framework class
class TestDsl < Minitest::Test
  def setup
    @hash_adapter = AutomationObject::BluePrint::HashAdapter.build({})
    @blue_prints = AutomationObject::BluePrint::Composite::Top.new(@hash_adapter)
  end

  def test_create
    dsl = AutomationObject::Dsl.create(@blue_prints, nil)
    assert dsl.is_a?(AutomationObject::Dsl::Top)
  end

  def teardown
  end
end
