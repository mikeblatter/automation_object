# frozen_string_literal: true
require_relative 'cache'

module AutomationObject
  module StepDefinitions
    # Class to parse arguments passed through step definitions
    class Parse
      # @param args [Array] input args from step definition
      def initialize(args)
        @args = args
      end

      def get
        parsed_args = []
        @args.each do |arg|
          parsed_args.push(parse(arg))
        end

        parsed_args
      end

      private

      # Used to parse any embedded variables
      # @param string [String] index of arg
      # @return [String] parsed string
      def parse(string)
        string.scan(/%\{[\w\d]+\}/) do |cache_key|
          unwrapped_cache_key = cache_key.gsub(/[%\{\}]/, '')

          cached_value = AutomationObject::StepDefinitions::Cache.get(unwrapped_cache_key)
          return cached_value if cached_value
        end

        string
      end
    end
  end
end
