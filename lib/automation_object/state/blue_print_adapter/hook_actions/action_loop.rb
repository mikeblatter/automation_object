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

        def driver
          return @args.fetch(:driver)
        end

        # Loops to run action for, default to 30
        # TODO: Maybe set some kind of constants somewhere for 30?
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