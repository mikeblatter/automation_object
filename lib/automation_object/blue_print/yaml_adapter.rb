require 'yaml'

require_relative '../helpers/file'
require_relative 'hash_adapter'

module AutomationObject
  module BluePrint
    # BluePrint YAML Adapter
    module YamlAdapter
      extend self

      # @param path [String] path to YAML directory
      # @return [AutomationObject::BluePrint::Composite::Top] Composite BluePrint Object
      def build(path = '')
        path = File.expand_path(path)

        file_array = File.collect_files(path)
        merged_yaml_hash = self.load_yaml_files(file_array)

        return AutomationObject::BluePrint::HashAdapter.build(merged_yaml_hash)
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
end
