require 'minitest/autorun'
require_relative '../lib/automation_object'

require 'minitest/unit'
require 'mocha/mini_test'
require 'minitest-bonus-assertions'

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '/test'
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
