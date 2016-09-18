module AutomationObject
  module State
    module Composite
      class ActionLoop
        attr_accessor :composite, :blue_prints, :loops

        def initialize(blue_prints, driver, composite, loops = 30)
          self.blue_prints = blue_prints
          self.driver = driver
          self.composite = composite
          self.loops = loops
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
