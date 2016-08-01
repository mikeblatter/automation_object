require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/automation_object'
  t.test_files = FileList['test/**/*_test.rb', 'spec/**/*_spec.rb']
  t.verbose = true
end

desc 'Build Gem'
task :build do
  system 'gem build automation_object.gemspec'
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