# frozen_string_literal: true
require_relative 'hook'

module AutomationObject
  module State
    module Composite
      # Helper module for Element composite classes
      module CommonElement
        def method_hook?(name)
          blue_prints.method_hooks.key?(name)
        end

        # @return [Hash<Hook>] array of Hook that are defined under the element
        def method_hooks
          return @method_hooks if @method_hooks

          @method_hooks = {}
          blue_prints.method_hooks.each do |key, blue_prints|
            @method_hooks[key] = Hook.new(session,
                                          driver,
                                          blue_prints,
                                          key,
                                          self,
                                          location + "[#{key}]")
          end

          @method_hooks
        end
      end
    end
  end
end
