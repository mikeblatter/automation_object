# frozen_string_literal: true

require_relative 'hook'

module AutomationObject
  module State
    # Helper module for Element composite classes
    module CommonElement
      attr_accessor :cache

      # Whether or not modal is active
      attr_accessor :active

      # @return [Boolean] screen is active or not
      def active?
        @active ||= false
      end

      def reset
        @active = false
        self.cache = nil
      end

      def method_hook?(name)
        blue_prints.method_hooks.key?(name)
      end

      # @return [Hash<Hook>] array of Hook that are defined under the element
      def method_hooks
        return @method_hooks if @method_hooks

        @method_hooks = {}
        blue_prints.method_hooks.each do |key, blue_prints|
          @method_hooks[key] = Hook.new(driver,
                                        blue_prints,
                                        key,
                                        self,
                                        location + "[#{key}]")
        end

        @method_hooks
      end

      def method_to_container(name)
        blue_prints.method_to_container(name)
      end
    end
  end
end
