module AutomationObject
  # Require step definitons at run-time, only when running in a Cucumber context
  module StepDefinitions
    extend self

    def load
      require 'minitest/autorun'
      require 'minitest/unit'
      require 'minitest-bonus-assertions'

      Dir[File.dirname(__FILE__) + '/step_definitions/**/*.rb'].each { |file| require file }
    end
  end
end
