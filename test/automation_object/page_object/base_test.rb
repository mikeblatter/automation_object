# frozen_string_literal: true

require_relative '../../test_helper'

require_relative '../../../lib/automation_object/page_object/base'


class ChildPageObjectTarget < AutomationObject::PageObject::Base
end


class TestPageObjectBase < Minitest::Test
  def setup
    ChildPageObjectTarget.configuration = {}
  end

  def test_set_property
    ChildPageObjectTarget.set_property('test_key', 'test_set_property')
    assert_equal 'test_set_property', ChildPageObjectTarget.configuration['test_key']
  end

  def test_get_property
    ChildPageObjectTarget.configuration['test_key'] = 'set_property'
    assert_equal 'set_property', ChildPageObjectTarget.get_property('test_key')
  end
end
