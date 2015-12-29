module AutomationObject
  module State
    module BluePrintAdapter
      class HookAction < Composite
        def initialize(args = {})
          @blue_prints = args.fetch(:blue_prints)
          @driver = args.fetch(:driver)
          @loops = args.fetch(:loops, 1)
        end

        # @return [Boolean] run success or not
        def run

        end
      end
    end
  end
end