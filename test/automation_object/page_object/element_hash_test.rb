# frozen_string_literal: true

require_relative '../../test_helper'

require_relative '../../../lib/automation_object/page_object/element_hash'


class ElementHashStub < AutomationObject::PageObject::ElementHash
  css 'css_path'
  xpath 'xpath_path'
  load 1
  in_iframe :test_element
  key :text
end


class TestPageObjectElementHash < Minitest::Test
  def test_css
    assert_equal 'css_path', ElementHashStub.new.css
  end

  def test_xpath
    assert_equal 'xpath_path', ElementHashStub.new.xpath
  end

  def test_load
    assert_equal 1, ElementHashStub.new.load
  end

  def test_in_iframe
    assert_equal :test_element, ElementHashStub.new.in_iframe
  end

  def test_key
    assert_equal :text, ElementHashStub.new.key
  end
end
