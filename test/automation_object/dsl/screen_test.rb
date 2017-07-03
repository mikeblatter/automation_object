# frozen_string_literal: true

require_relative '../../test_helper'

# Test AutomationObject::Dsl::Screen
class TestDslScreen < Minitest::Test
  def setup
    @blue_prints = stub(elements: {}, element_arrays: {}, element_hashes: {}, modals: {})
    @state = stub(active?: true)
  end

  def teardown; end

  def test_active?
    dsl = AutomationObject::Dsl::ScreenProxy.new(@blue_prints, @state, :test)
    assert_equal true, dsl.active?
  end
end
