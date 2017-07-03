# frozen_string_literal: true

require_relative '../../test_helper'

# Test AutomationObject::Dsl::Modal
class TestDslModal < Minitest::Test
  def setup
    @blue_prints = stub(elements: {}, element_arrays: {}, element_hashes: {})
    @state = stub(active?: true)
  end

  def teardown; end

  def test_active?
    dsl = AutomationObject::Dsl::ModalProxy.new(@blue_prints, @state, :test)
    assert_equal true, dsl.active?
  end
end
