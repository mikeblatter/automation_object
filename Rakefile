# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'fileutils'
require 'awesome_print'

module Cucumber
  JRUBY = nil
end

# Auto documentation
require 'yard'
require 'redcarpet'
require 'rubocop/rake_task'
require 'rubycritic/rake_task'

THIS_DIRECTORY = File.expand_path(__dir__).freeze
LINTABLE_PATHS = [File.join(THIS_DIRECTORY, 'lib/**/*.rb'),
                  File.join(THIS_DIRECTORY, 'test/**/*.rb')].freeze
GEM_NAME = 'automation_object'

# Testing Tasks
Rake::TestTask.new do |task|
  task.libs << "lib/#{GEM_NAME}"
  task.test_files = FileList['test/**/*_test.rb', 'spec/**/*_spec.rb']
  task.verbose = true
end

# Linting
RuboCop::RakeTask.new do |task|
  task.options = ['--auto-correct']
end

# Documentation
YARD::Rake::YardocTask.new do |task|
  task.files   = ['lib/**/*.rb']
  task.options = ['--markup-provider=redcarpet', '--markup=markdown',
                  '--output-dir=docs/internal']
end

RubyCritic::RakeTask.new do |task|
  task.paths = FileList['lib/**/*.rb']
  task.options = '--no-browser --path docs/rubycritic'
end

Rake::Task[:rubycritic].enhance do
  rubycritic_dir = File.join(THIS_DIRECTORY, 'docs/rubycritic')

  rubycritic_overview = File.join(rubycritic_dir, 'overview.html')
  rubycritic_index = File.join(rubycritic_dir, 'index.html')

  # Need to change overview.html to index
  FileUtils.cp(rubycritic_overview, rubycritic_index)
end

desc 'Build Docs'
task docs: %i[yard rubycritic] do
end

# Building
desc 'Build Gem'
task :build do#: %i[rubocop test] do
  system "gem build #{GEM_NAME}.gemspec"

  remove_gem = File.expand_path(File.join(__dir__, "#{GEM_NAME}-#{AutomationObject::VERSION}.gem"))
  FileUtils.rm(remove_gem)
end

desc 'Install Gem'
task :install do#: :build do
  system "gem install ./pkg/#{GEM_NAME}-#{AutomationObject::VERSION}.gem"
end

desc 'Release Gem'
task release: [:install] do
  system "gem push ./pkg/#{GEM_NAME}-#{AutomationObject::VERSION}.gem"
end

task default: :test
