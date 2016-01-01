module AutomationObject
  module State
    module BluePrintAdapter
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

        def single_run
          raise 'Abstract issue'
        end
      end
    end
  end
end