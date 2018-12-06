# frozen_string_literal: true

require 'yaml'

require_relative '../helpers/file'
require_relative 'hash_adapter'

module AutomationObject
  module BluePrint
    # BluePrint YAML Adapter
    module YamlAdapter
      module_function

      # @param path [String] path to YAML directory
      # @return [AutomationObject::BluePrint::Composite::Top] Composite BluePrint Object
      def build(path)
        # Check if directory exists otherwise throw error
        raise ArgumentError, 'Expecting path to exist' unless Dir.exist?(path)

        path = File.expand_path(path)

        file_array = File.collect_files(path)
        merged_yaml_hash = load_yaml_files(file_array)

        AutomationObject::BluePrint::HashAdapter.build(merged_yaml_hash)
      end

      # @param file_array [Array<String>] array of file paths to load
      # @return [Hash] merged YAML Hash
      def load_yaml_files(file_array)
        merged_yaml_hash = {}

        file_array.each do |file_path|
          next unless yaml_file?(file_path)

          file_hash = YAML.load_file(file_path)

          raise "Expecting file #{file_path} to be a hash when loaded" unless file_hash.is_a?(Hash)

          merged_yaml_hash = merged_yaml_hash.deep_merge(file_hash)
        end

        merged_yaml_hash
      end

      # @param file_path [String] file path
      # @return [Boolean] whether or not it is a YAML file
      def yaml_file?(file_path)
        file_path =~ /\.ya?ml$/ ? true : false
      end
    end
  end
end
