require_relative '_base'

class TestElementHashStepDefinitions < Minitest::Test
  include StepDefinitionsTestBase

  create_tests 'element_hash.rb'
end