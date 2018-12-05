# frozen_string_literal: true

require_relative '../../test_helper'

# Test AutomationObject::BluePrint::PageObjectAdapter
class TestPageObjectAdapter < Minitest::Test
  def test_undefined_path_error
    assert_raises ArgumentError do
      AutomationObject::BluePrint::PageObjectAdapter.build('/sdsdsd/sdds/ds')
    end
  end
end
