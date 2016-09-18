require_relative '../../test_helper'

# Test String
class TestString < Minitest::Test
  def setup
    @url_valid_hash = {
      'http://google.com' => true,
      'www.google.com' => false,
      'https://www.google.com' => true,
      'http://www.google.com' => true,
      'google.com' => false,
      'http://test.google.com/path/to/fake/url' => true
    }
  end

  def test_valid_url
    @url_valid_hash.each do |url, is_valid_url|
      assert_equal(url.valid_url?, is_valid_url)
    end
  end

  def test_pascalize
    assert_equal 'test_string'.pascalize, 'TestString'
    assert_equal 'test_string_again'.pascalize, 'TestStringAgain'
  end
end
