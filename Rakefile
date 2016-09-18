require 'bundler/gem_tasks'
require 'rake/testtask'
require 'fileutils'
require 'awesome_print'
require 'yard'
require 'redcarpet'

require 'rubocop/rake_task'

require 'coveralls/rake/task'

THIS_DIRECTORY = File.expand_path(__dir__).freeze
LINTABLE_PATHS = [File.join(THIS_DIRECTORY, 'lib/**/*.rb'),
                  File.join(THIS_DIRECTORY, 'test/**/*.rb')].freeze
GEM_NAME = 'automation_object'.freeze

# Testing Tasks
Rake::TestTask.new do |t|
  t.libs << "lib/#{GEM_NAME}"
  t.test_files = FileList['test/**/*_test.rb', 'spec/**/*_spec.rb']
  t.verbose = true
end

# Linting
RuboCop::RakeTask.new do |t|
  t.options = ['--auto-correct']
end

# Documentation
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['--markup-provider=redcarpet', '--markup=markdown',
               '--output-dir=docs/internal']
end

# Building
desc 'Build Gem'
task build: [:test, :lint_files, :rubocop, :yard] do
  system "gem build #{GEM_NAME}.gemspec"

  remove_gem = File.expand_path(File.join(__dir__, "#{GEM_NAME}-#{AutomationObject::VERSION}.gem"))
  FileUtils.rm(remove_gem)
end

desc 'Install Gem'
task install: :build do
  system "gem install ./pkg/#{GEM_NAME}-#{AutomationObject::VERSION}.gem"
end

desc 'Release Gem'
task release: [:install] do
  system "gem push ./pkg/#{GEM_NAME}-#{AutomationObject::VERSION}.gem"
end

task default: :test
