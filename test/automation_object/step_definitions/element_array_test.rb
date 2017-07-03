# frozen_string_literal: true

require_relative '../../test_helper'
require_relative '_base'

class TestElementArrayStepDefinitions < Minitest::Test
  include StepDefinitionsTestBase

  create_tests 'element_array.rb'
end
