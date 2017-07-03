# frozen_string_literal: true

require_relative '../../test_helper'
require_relative '_base'

class TestScreenStepDefinitions < Minitest::Test
  include StepDefinitionsTestBase

  create_tests 'screen.rb'
end
