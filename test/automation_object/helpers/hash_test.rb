require_relative '../../test_helper'

#Test Hash
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

    assert_equal merged_hash.has_key?('test_two'), true
    assert_equal merged_hash['test_two'].has_key?('test_three'), true
    assert_equal merged_hash['test_two']['test_three']['test_four'], 'blah'
  end

  def test_symbolize_keys_deep!
    cloned_hash = @first_hash
    cloned_hash.symbolize_keys_deep!

    assert_equal cloned_hash.has_key?('test_one'), false
    assert_equal cloned_hash.has_key?(:test_one), true

    assert_equal cloned_hash.has_key?('test_two'), false
    assert_equal cloned_hash.has_key?(:test_two), true

    assert_equal cloned_hash[:test_two].has_key?('test_three'), false
    assert_equal cloned_hash[:test_two].has_key?(:test_three), true
  end
end