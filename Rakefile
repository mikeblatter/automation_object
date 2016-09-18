require 'bundler/gem_tasks'
require 'rake/testtask'
require 'fileutils'
require 'awesome_print'
require 'yard'
require 'redcarpet'

require 'rubocop/rake_task'

THIS_DIRECTORY = File.expand_path(__dir__).freeze
LINTABLE_PATHS = [File.join(THIS_DIRECTORY, 'lib/**/*.rb'),
                  File.join(THIS_DIRECTORY, 'test/**/*.rb')]
# Testing Tasks
Rake::TestTask.new do |t|
  t.libs << 'lib/automation_object'
  t.test_files = FileList['test/**/*_test.rb', 'spec/**/*_spec.rb']
  t.verbose = true
end

#Linting
desc 'Update files to help meet rubocops standards'
task :lint_files do
  LINTABLE_PATHS.each do |path|
    Dir.glob(path) do |file|
      file_content = File.read(file)

      file_content.gsub!(/\n+$/, '')
      file_content += "\n"
      
      # Overwrite file
      File.write(file, file_content)
    end
  end
end

RuboCop::RakeTask.new do |t|
end
task :rubocop => :lint_files

# Documentation
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['--markup-provider=redcarpet', '--markup=markdown',
               '--output-dir=docs/internal']
end

# Building
desc 'Build Gem'
task :build => [:test, :lint_files, :rubocop, :yard] do
  system 'gem build automation_object.gemspec'
  FileUtils.rm(File.expand_path(File.join(__dir__, "automation_object-#{AutomationObject::VERSION}.gem")))
end

desc 'Install Gem'
task :install => :build do
  system "gem install ./pkg/automation_object-#{AutomationObject::VERSION}.gem"
end

desc 'Release Gem'
task :release => [:install] do
  system "gem push ./pkg/automation_object-#{AutomationObject::VERSION}.gem"
end

task :default => :test