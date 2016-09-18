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
          self.adapter.before
        end

        # @return [HookAction]
        def after
          self.adapter.after
        end

        # @return [Array<HookElementRequirements>] array of element requirements
        def live?
          self.adapter.live?
        end
      end
    end
  end
end
