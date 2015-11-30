module AutomationObject
  module State
    module BluePrintAdapter
      class ActionLoop
        def initialize(args = {})
          @args = args
        end

        def blue_prints
          return @args.fetch(:blue_prints)
        end

        def session
          return @args.fetch(:session)
        end

        # @return [Integer] loops
        def loops
          return @args.fetch(:loops, 30)
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