require 'awesome_print'

STEP_DEFINITION_FILES = File.join(__dir__, '../lib/automation_object/step_definitions/*.rb')
DOCS_DIRECTORY = File.expand_path(File.join(__dir__, '../docs/step_definitions'))

def present_underscore(string)
  return string if string !~ /_/ && string =~ /[A-Z]+.*/
  string.split('_').map(&:capitalize).join(' ')
end

def file_description(line_array)
  return line_array.join('').match(/# Description:\s*(.+)/)[1] + "\n\n"
end

def file_table_of_contents(line_array)
  text = "\n\n## Table of Contents\n\n"

  line_array.each { |line|
    for_line = line.match(/For:\s*(.+)/)
    next unless for_line

    text += "- [#{for_line[1]}](#{for_line[1]})\n"
  }

  text + "\n"
end

def file_steps(line_array)
  text = "## Steps \n\n"

  added_examples = false
  line_array.each { |line|
    for_line = line.match(/For:\s*(.+)/)
    example_line = line.match(/^# \s*-\s*(.+)/)
    regex_line = line.match(%r{^(?:Given|When|Then|But|And)[r%\{\s\(\/]+(.+)\/[\s\)\}]+})

    if for_line
      added_examples = false
      text += "\n\n### #{for_line[1]}\n\n"
    end

    if example_line
      unless added_examples
        text += "#### Examples\n\n"
        added_examples = true
      end

      text += "- #{example_line[1]}\n"
    end

    if regex_line
      text += "\n\n#### Regex\n\n"
      text += "```#{regex_line[1]}```\n\n\n"
    end
  }

  text
end

Dir.glob(STEP_DEFINITION_FILES) do |step_def_file|
  file_title = step_def_file.match(/\/(\w+)\.rb$/)[1]

  doc_file = File.join(DOCS_DIRECTORY, "#{file_title}.md")
  doc_file_contents = "# #{present_underscore(file_title)} Step Definitions\n\n"

  line_array = []
  File.open(step_def_file, 'r') do |file_handle|
    file_handle.each_line {|line| line_array.push(line) }
  end

  doc_file_contents += file_description(line_array)
  doc_file_contents += file_table_of_contents(line_array)
  doc_file_contents += file_steps(line_array)

  File.open(doc_file, 'w') { |file| file.write(doc_file_contents) }
end