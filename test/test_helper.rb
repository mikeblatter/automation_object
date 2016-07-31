require 'minitest/autorun'
require_relative '../lib/automation_object'

require 'minitest/unit'
require 'mocha/mini_test'
require 'minitest-bonus-assertions'

#Extension of Assertions
module Minitest::Assertions
  def refute_raises *exp
    msg = "#{exp.pop}.\n" if String === exp.last

    begin
      yield
    rescue Minitest::Skip => e
      return e if exp.include? Minitest::Skip
      raise e
    rescue Exception => e
      expected = exp.any? { |ex|
        if ex.instance_of? Module then
          e.kind_of? ex
        else
          e.instance_of? ex
        end
      }

      assert expected, proc {
                       exception_details(e, "#{msg}#{mu_pp(exp)} exception not expected, not")
                     }

      exp = exp.first if exp.size == 0
      flunk "#{msg}#{mu_pp(exp)} not expected but was raised."

      return e
    end



    pass "#{msg}#{mu_pp(exp)} not expected but nothing was raised."
    #
  end
end