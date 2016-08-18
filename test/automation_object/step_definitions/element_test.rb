require_relative '../../test_helper'

ELEMENT_FILE_PATH = File.expand_path(File.join(__dir__, '../../../lib/automation_object/step_definitions/element.rb'))

class TestElementStepDefinitions < Minitest::Test
  def setup
  end

  def teardown
  end

  examples = []
  File.open(ELEMENT_FILE_PATH, 'r') do |file_handle|
    file_handle.each_line do |line|
      case
        when line.match(/^#\s*-\s*/)
          examples.push(line.gsub(/^#\s*-\s*/, ''))
        when line.match(/^(?:Given|When|Then|But|And)\s*\(\s*\/(.+)\/\s*\)/)
          regex = Regexp.new(line.match(/^(?:Given|When|Then|But|And)\s*\(\s*\/(.+)\/\s*\)/)[1])

          examples.each { |example|
            define_method("test_regex_#{example.gsub(/\W/, '').downcase}") do
              assert example.match(regex)
            end
          }

          examples = []
      end
    end
  end
end