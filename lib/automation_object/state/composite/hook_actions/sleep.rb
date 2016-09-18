require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      class Sleep < ActionLoop
        def initialize(args = {})
          super
          @time = args.fetch :blue_prints
        end

        def single_run
          sleep(@time)
        end
      end
    end
  end
end
