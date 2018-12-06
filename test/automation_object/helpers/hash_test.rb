# frozen_string_literal: true

require_relative '../../test_helper'

# Test Hash
class TestHash < Minitest::Test
  def setup
    @first_hash = {
      'test_one' => 'blah',
      'test_two' => {
        'test_three' => {
          'test_four' => 'blah'
        }
      }
    }

    @second_hash = {
      'test_two' => {
      }
    }
  end

  def test_deep_merge
    merged_hash = @first_hash.deep_merge(@second_hash)

    assert_equal true, merged_hash.key?('test_two')
    assert_equal true, merged_hash['test_two'].key?('test_three')
    assert_equal 'blah', merged_hash['test_two']['test_three']['test_four']
  end

  def test_symbolize_keys_deep!
    cloned_hash = @first_hash
    cloned_hash.symbolize_keys_deep!

    assert_equal false, cloned_hash.key?('test_one')
    assert_equal true, cloned_hash.key?(:test_one)

    assert_equal false, cloned_hash.key?('test_two')
    assert_equal true, cloned_hash.key?(:test_two)

    assert_equal false, cloned_hash[:test_two].key?('test_three')
    assert_equal true, cloned_hash[:test_two].key?(:test_three)
  end
end
