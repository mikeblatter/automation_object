# frozen_string_literal: true
require_relative '../../test_helper'
require_relative '../../../lib/automation_object/helpers/file'

# Work around for collect_files, since we are extending File
# FakeFS interferes with the methods called on the File class causing an error
FileCopy = File

# fakess - Fake file system gem
require 'fakefs/safe'

# Test AutomationObject::BluePrint::FileHelper
class TestBluePrintFileHelper < Minitest::Test
  DIRS = %w(/test /test/first_dir /test/second_dir).freeze
  FILES = %w(/test/test_file /test/test_file_two /test/first_dir/test_file_three /test/second_dir/test_file_four /test/second_dir/test_file_five).freeze

  def setup
    FakeFS.activate!

    DIRS.each do |directory|
      FileUtils.mkdir_p(directory)
    end

    FILES.each do |file|
      FileUtils.touch(file)
    end
  end

  def teardown
    all_entities = DIRS + FILES
    all_entities.each do |path|
      FileUtils.rm_r(path) if File.exist?(path)
    end

    FakeFS.deactivate!
  end

  # Test FakeFS to make sure it is working properly
  DIRS.each do |directory|
    define_method("test_fs_directory_#{directory.gsub(/\W/, '').downcase}") do
      assert File.directory?(directory)
    end
  end

  FILES.each do |file|
    define_method("test_fs_file_#{file.gsub(/\W/, '').downcase}") do
      assert File.exist?(file)
    end
  end

  def test_collect_files_type
    collected_files = FileCopy.collect_files('/test')
    assert_equal collected_files.class, Array
  end

  def test_collect_files_length
    collected_files = FileCopy.collect_files('/test')
    assert_equal collected_files.length, 5
  end

  # Test collected files
  FILES.each do |file|
    define_method("test_collected_files_included_#{file.gsub(/\W/, '').downcase}") do
      collected_files = FileCopy.collect_files('/test')
      assert_includes collected_files, '/test/test_file'
    end
  end
end
