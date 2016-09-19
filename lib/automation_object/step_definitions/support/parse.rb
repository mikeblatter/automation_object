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
        parsed_string = string

        string.scan(/%\{(\w+)\}/) do |cache_key|
          cached_value = AutomationObject::StepDefinitions::Cache.get(cache_key)
          next unless cached_value

          parsed_string.gsub("%{#{cache_key}}", cached_value)
        end

        parsed_string
      end
    end
  end
end
