# frozen_string_literal: true
# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # Hook composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class Hook < Base
        # @return [HookAction]
        def before
          adapter.before
        end

        # @return [HookAction]
        def after
          adapter.after
        end

        # @return [Array<HookElementRequirements>] array of element requirements
        def live?
          adapter.live?
        end
      end
    end
  end
end
