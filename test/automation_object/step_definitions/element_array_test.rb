require_relative '_base'

class TestElementArrayStepDefinitions < Minitest::Test
  include StepDefinitionsTestBase

  create_tests 'element_array.rb'
end
