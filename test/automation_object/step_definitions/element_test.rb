require_relative '_base'

class TestElementStepDefinitions < Minitest::Test
  include StepDefinitionsTestBase

  create_tests 'element.rb'
end