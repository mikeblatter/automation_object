require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/helpers/file_helper'

#fakess - Fake file system gem
require 'fakefs/safe'

#Test AutomationObject::BluePrint::FileHelper
class TestBluePrintFileHelper < Minitest::Test
  def setup
    FakeFS.activate!

    FileUtils.rm_r('/test') if File.exists?('/test')

    FileUtils.mkdir('/test')
    FileUtils.mkdir('/test/first_dir')
    FileUtils.mkdir('/test/second_dir')

    FileUtils.touch('/test/test_file')
    FileUtils.touch('/test/test_file_two')
    FileUtils.touch('/test/first_dir/test_file_three')
    FileUtils.touch('/test/second_dir/test_file_four')
    FileUtils.touch('/test/second_dir/test_file_five')
  end

  def teardown
    FakeFS.deactivate!
  end

  #Make sure fakefs gem is working as I expect
  def test_fs_setup
    FakeFS.activate!

    assert File.directory?('/test')
    assert File.directory?('/test/first_dir')
    assert File.directory?('/test/second_dir')

    assert File.exists?('/test/test_file')
    assert File.exists?('/test/test_file_two')
    assert File.exists?('/test/first_dir/test_file_three')
    assert File.exists?('/test/second_dir/test_file_four')
    assert File.exists?('/test/second_dir/test_file_five')

    FakeFS.deactivate!
  end

  #Test collect_files methods based on fakefs created folders/files
  def test_collect_files
    FakeFS.activate!

    stub_for_helper = stub
    stub_for_helper.extend(AutomationObject::BluePrint::FileHelper)

    collected_files = stub_for_helper.collect_files('/test')

    assert_equal collected_files.class, Array
    assert_equal collected_files.length, 5

    assert_includes collected_files, '/test/test_file'
    assert_includes collected_files, '/test/test_file_two'
    assert_includes collected_files, '/test/first_dir/test_file_three'
    assert_includes collected_files, '/test/second_dir/test_file_four'
    assert_includes collected_files, '/test/second_dir/test_file_five'

    FakeFS.deactivate!
  end
end