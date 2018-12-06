# frozen_string_literal: true

require 'ap'

DOCS_PATH = File.join(File.expand_path(__dir__), 'step_definitions')

$steps = []

def When(regex)
  add_step(regex, caller_locations[0])
end

def Then(regex)
  add_step(regex, caller_locations[0])
end

def add_step(regex, caller)
  ruby_code = File.readlines(caller.path)

  step = Step.new
  step.path = caller.path
  step.lineno = caller.lineno
  step.regex = regex.to_s.gsub('(?-mix:', '').gsub(/\)$/, '')

  before_function_line = caller.lineno - 2
  before_function_line.downto(0) do |lineno|
    break unless ruby_code[lineno] =~ /^#/
    next if ruby_code[lineno].match('Examples:')

    if ruby_code[lineno] =~ /^\s*#\s*-/
      step.examples << ruby_code[lineno].gsub(/^\s*#\s*-/, '')
    else
      step.title = ruby_code[lineno].gsub(/^\s*#\s*/, '')
    end
  end

  $steps << step
end

class Step
  attr_accessor :title, :path, :lineno, :examples, :regex

  def examples
    @examples ||= []
  end
end

class StepDefinition
  attr_accessor :path, :name, :title

  def initialize(path)
    $steps = []

    self.path = path
    self.name = File.basename(path, '.rb')
    self.title = "#{name.tr('_', ' ').split.map(&:capitalize).join(' ')} Step Definitions\n"

    require path
  end

  def description
    contents = File.read(path)

    description_match = contents.match(/\s*#\s*Description: ([^\n]+)/)

    return '' unless description_match && (description_match.length > 1)

    description_match[1]
  end

  def output
    output = "# #{title}\n"
    output += "#{description}\n"

    output += "## Steps: \n\n"

    $steps.each do |step|
      output += "### #{step.title} \n"

      output += "#### Examples: \n\n"

      step.examples.each do |example|
        output += "* #{example}\n"
      end

      output += "\n#### Regex: \n\n ```\n#{step.regex}\n```\n\n"
      output += "----\n\n"
    end

    output
  end

  def generate
    doc_path = File.join(DOCS_PATH, "#{name}.md")

    File.open(doc_path, 'w') do |file|
      file.write(output)
    end
  end
end
