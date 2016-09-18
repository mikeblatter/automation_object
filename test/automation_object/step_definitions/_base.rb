require_relative '../../test_helper'

# Common functionality for step definition tests
module StepDefinitionsTestBase
  def setup
  end

  def teardown
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    STEP_DEFINITION_FILES = File.join(__dir__, '../../../lib/automation_object/step_definitions/*.rb')
    STEP_DEFINITION_DIR = File.expand_path(File.join(__dir__, '../../../lib/automation_object/step_definitions/'))

    def create_tests(file_name)
      all_examples = []
      Dir.glob(STEP_DEFINITION_FILES) do |step_def_file|
        File.open(step_def_file, 'r') do |file_handle|
          file_handle.each_line do |line|
            all_examples.push(line.gsub(/^# \s*-\s*/, '')) if line =~ /^# \s*-\s*/
          end
        end
      end

      examples = []
      File.open(File.join(STEP_DEFINITION_DIR, file_name), 'r') do |file_handle|
        file_handle.each_line do |line|
          if line =~ /^# \s*-\s*/
            examples.push(line.gsub(/^# \s*-\s*/, ''))
          elsif line =~ /^(?:Given|When|Then|But|And)\s*\(\s*\/(.+)\/\s*\)/
            regex = Regexp.new(line.match(/^(?:Given|When|Then|But|And)[\s\(\/]+(.+)\/[\s\)]+/)[1])

            # Iterate through examples and test the regex matches the example
            # This way we know the documentation is accurate and if any updates will break existing implmentations
            examples.each do |example|
              define_method("test_assert_regex_#{regex.to_s.gsub(/\W/, '')}_#{example.gsub(/\W/, '').downcase}") do
                assert example.match(regex), "Expecting example: #{example} to match regex: #{regex}"
              end
            end

            # Test all the examples minus the current ones don't match the Regex
            # This way we can make sure we are not overlapping in any examples
            bad_examples = all_examples - examples

            bad_examples.each do |bad_example|
              define_method("test_refute_regex_#{regex.to_s.gsub(/\W/, '')}_#{bad_example.gsub(/\W/, '').downcase}") do
                refute bad_example.match(regex), "Expecting other definition example: #{bad_example} to not match regex: #{regex}"
              end
            end

            # Reset Examples
            examples = []
          end
        end
      end
    end
  end
end
