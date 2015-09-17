require 'yaml'

require_relative 'hash_adapter'
require_relative 'helpers/file_helper'

module AutomationObject::BluePrint
  #BluePrint YAML Adapter
  module YamlAdapter
    extend self
    extend FileHelper

    # @param path [String] path to YAML directory
    # @return [AutomationObject::BluePrint::HashAdapter::Top] Composite BluePrint Object
    def self.build_composite(path = '')
      path = File.expand_path(path)

      file_array = self.collect_files(path)
      merged_yaml_hash = self.load_yaml_files(file_array)

      return HashAdapter.build_composite(merged_yaml_hash)
    end

    # @param file_array [Array<String>] array of file paths to load
    # @return [Hash] merged YAML Hash
    def load_yaml_files(file_array)
      merged_yaml_hash = Hash.new

      file_array.each { |file_path|
        next unless self.is_yaml_file?(file_path)

        file_hash = YAML.load_file(file_path)

        unless file_hash.is_a?(Hash)
          raise "Expecting file #{file_path} to be a hash when loaded"
        end

        merged_yaml_hash = merged_yaml_hash.deep_merge(file_hash)
      }

      return merged_yaml_hash
    end

    # @param file_path [String] file path
    # @return [Boolean] whether or not it is a YAML file
    def is_yaml_file?(file_path)
      return (file_path.match(/\.ya?ml$/)) ? true : false
    end
  end
end