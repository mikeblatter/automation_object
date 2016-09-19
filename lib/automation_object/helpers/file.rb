# frozen_string_literal: true
# Extend file class
# Collect files in directory recursively and return Array
class File
  class << self
    # @param path [String] specified directory path for getting files underneath
    # @returns [Array] list of file paths that exist recursively underneath a directory
    def collect_files(path)
      raise "Expecting path to exist, got #{path}" unless File.exist?(path)

      if File.directory?(path)
        @file_array = []
        recursive_collection(path)
      else
        @file_array = [path]
      end

      @file_array
    end

    protected

    # Use for recursive collection of files
    # @param path [String] specified directory path for getting files underneath
    def recursive_collection(path)
      Dir.foreach(path) do |item|
        next if item == '.' || item == '..'

        file_path = File.join(path, item.to_s)
        if File.directory?(file_path)
          recursive_collection(file_path)
        else
          @file_array.push(file_path)
        end
      end
    end
  end
end
