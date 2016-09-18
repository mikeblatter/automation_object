require 'bundler/gem_tasks'
require 'rake/testtask'
require 'fileutils'

#Documentation
require 'yard'
require 'redcarpet'

Rake::TestTask.new do |t|
  t.libs << 'lib/automation_object'
  t.test_files = FileList['test/**/*_test.rb', 'spec/**/*_spec.rb']
  t.verbose = true
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['--markup-provider=redcarpet', '--markup=markdown',
               '--output-dir=docs/internal']
end

desc 'Build Gem'
task :build => [:test] do
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