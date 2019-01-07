# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'automation_object/version'

Gem::Specification.new do |spec|
  spec.name = 'automation_object'
  spec.version = AutomationObject::VERSION
  spec.authors = ['Michael Blatter']
  spec.email = 'automation_object@blatter.me'
  spec.summary = 'Configuration Based UI Automation'
  spec.description = 'AutomationObject uses UI configurations to generate a usable DSL object representing the UI you want to automate. Also includes builtin Cucumber step definitions to get you up and running quick'
  spec.homepage = 'https://github.com/mikeblatter/automation_object'
  spec.license = 'MIT'

  spec.files = Dir.glob('{lib}/**/*')
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(docs|test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2'

  # Installation
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 12.3'

  # Code Checking
  spec.add_development_dependency 'rubocop', '~> 0.60'
  spec.add_development_dependency 'rubycritic', '~> 3.5'

  # Documentation
  spec.add_development_dependency 'redcarpet', '~> 3.4'
  spec.add_development_dependency 'yard', '~> 0.9'

  # Debugging
  spec.add_development_dependency 'awesome_print', '~> 1.8'
  spec.add_development_dependency 'pry', '~> 0.12'

  # Testing
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'fakefs', '~> 0.18'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'minitest-bonus-assertions', '~> 3.0'
  spec.add_development_dependency 'mocha', '~> 1.7'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'simplecov-console', '~> 0.4'

  # Integration Testing
  spec.add_runtime_dependency 'appium_lib', '~> 9.16'
  spec.add_runtime_dependency 'selenium-webdriver', '~> 3.141'

  # Step Definition Testing
  spec.add_runtime_dependency 'rspec-expectations', '~> 3.8'

  # Runtime dependencies
  spec.add_runtime_dependency 'colorize', '~> 0.8'

  # Events
  spec.add_runtime_dependency 'event_emitter', '~> 0.2'

  # For step definitions
  spec.add_runtime_dependency 'cucumber', '~> 3.1'

  # XML Driver
  spec.add_runtime_dependency 'nokogiri', '~> 1.8'
  spec.add_runtime_dependency 'rest-client', '~> 2.0'
end
