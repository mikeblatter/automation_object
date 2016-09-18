# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'automation_object/version'

Gem::Specification.new do |spec|
  spec.name = 'automation_object'
  spec.version = AutomationObject::VERSION
  spec.authors = ['Michael Blatter']
  spec.summary = 'YAML configuration based dynamic DSL framework for UI automation using Selenium or Appium drivers.'
  spec.description = 'This gem provides a way to create a dynamic usable DSL framework representing your website or app.
Implementing Selenium/Appium driver and YAML configurations, this API will provide a layer in between your automation code and the driver.
By creating YAML configurations that represents your website/app, the DSL framework in turn will reflect your configuration
and allow you to control the automation through the DSL framework.  Using this gem can help remove tedious tasks that are often
repeated throughout code and help improve the scalability of code by mapping UI in YAML configuration files.'
  spec.homepage = 'https://github.com/mikeblatter/automation_object'
  spec.license = 'MIT'

  # spec.files = `git ls-files -z`.split("\x0")
  spec.files = Dir.glob('{lib}/**/*')
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(docs|test|spec|features)/})
  spec.require_paths = ['lib']

  # Installation
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  # Lint
  spec.add_development_dependency 'rubocop', '~> 0.42'

  # Documentation
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'redcarpet', '~> 3.3'

  # Testing and debugging
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'minitest', '~> 5.9'
  spec.add_development_dependency 'minitest-bonus-assertions', '~> 2.0'

  spec.add_development_dependency 'mocha', '~> 1.1'
  spec.add_development_dependency 'fakefs', '~> 0.9'

  spec.add_development_dependency 'awesome_print', '~> 1.7'

  # Runtime dependencies
  spec.add_runtime_dependency 'colorize', '~> 0.8'

  # Events
  spec.add_runtime_dependency 'event_emitter', '~> 0.2'

  # For step definitions
  spec.add_runtime_dependency 'cucumber', '~> 2.4'

  # XML Driver
  spec.add_runtime_dependency 'rest-client', '~> 2.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'

  # Supported Drivers
  spec.add_runtime_dependency 'appium_lib', '~> 8.0'
  spec.add_runtime_dependency 'selenium-webdriver', '~> 2.53'
end
