# frozen_string_literal: true

require_relative '../lib/automation_object'

require 'minitest/autorun'

require 'minitest/unit'
require 'mocha/minitest'
require 'minitest-bonus-assertions'

require 'simplecov'
require 'coveralls'

BASE_DIR = File.expand_path(File.join(__dir__, '../'))
AO_LIB_DIR = File.join(BASE_DIR, 'lib/automation_object')

def automation_object_require(path)
  require(File.join(AO_LIB_DIR, path))
end

SimpleCov.root(BASE_DIR)
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_group 'BluePrint', '../lib/automation_object/blue_print'
  add_group 'Dsl', '../lib/automation_object/dsl'
  add_group 'State', '../lib/automation_object/state'
  add_group 'Driver', '../lib/automation_object/driver'

  add_filter '../test'
  add_filter '../test_integration'
  add_filter '../docs'
end

# Extension of Assertions
module Minitest
  module Assertions
    # Assert sure a block doesn't raise an exception
    def refute_raises(*expected)
      msg = "#{expected.pop}.\n" if expected.last.is_a?(String)

      begin
        yield
      rescue Minitest::Skip => exception
        return exception if expected.include? Minitest::Skip

        raise exception
      rescue StandardError => exception
        expected = expected.any? do |ex|
          if ex.instance_of? Module
            exception.is_a? ex
          else
            exception.instance_of? ex
          end
        end

        assert expected, proc {
          message = "#{msg}#{mu_pp(expected)} exception not expected, not"
          exception_details(exception, message)
        }

        expected = expected.first if expected.size.zero?
        flunk "#{msg}#{mu_pp(expected)} not expected but was raised."

        return exception
      end

      pass "#{msg}#{mu_pp(expected)} not expected but nothing was raised."
    end
  end
end
