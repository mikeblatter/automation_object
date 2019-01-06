# frozen_string_literal: true

require_relative '../../test_helper'

require_relative '../../../lib/automation_object/page_object/element'


class ElementStub < AutomationObject::PageObject::Element
  css 'css_path'
  xpath 'xpath_path'
  load 1
  in_iframe :test_element
end


class TestPageObjectConfiguration < Minitest::Test
  def test_css
    assert_equal 'css_path', ElementStub.new.css
  end

  def test_xpath
    assert_equal 'xpath_path', ElementStub.new.xpath
  end

  def test_load
    assert_equal 1, ElementStub.new.load
  end

  def test_in_iframe
    assert_equal :test_element, ElementStub.new.in_iframe
  end
end
