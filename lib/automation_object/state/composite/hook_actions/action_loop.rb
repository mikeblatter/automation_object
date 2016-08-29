module AutomationObject
  module State
    module Composite
      class ActionLoop
        attr_accessor :composite, :blue_prints, :loops

        def initialize(args = {})
          self.blue_prints = args.fetch(:blue_prints)
          self.composite = args.fetch(:composite)
          self.loops = args.fetch(:loops, 30)
        end

        def driver
          return self.composite.driver
        end

        # @return [Boolean] run success or not
        def run
          self.loops.times do
            if self.single_run
              return true
            end
          end

          return false
        end

        # @return [Boolean] success or not
        def single_run
          raise 'Abstract Issue'
        end
      end
    end
  end
end