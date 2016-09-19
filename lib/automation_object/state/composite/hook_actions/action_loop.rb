# frozen_string_literal: true
module AutomationObject
  module State
    module Composite
      # Composte action loop base class
      class ActionLoop
        attr_accessor :composite, :blue_prints, :loops

        def initialize(blue_prints, driver, composite, loops = 30)
          self.blue_prints = blue_prints
          self.driver = driver
          self.composite = composite
          self.loops = loops
        end

        def driver
          composite.driver
        end

        # @return [Boolean] run success or not
        def run
          loops.times do
            return true if single_run
          end

          false
        end

        # @return [Boolean] success or not
        def single_run
          raise 'Abstract Issue'
        end
      end
    end
  end
end
