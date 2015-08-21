module AutomationObject
  module State
    module BluePrintAdapter
      class HookElementRequirement < Composite
        attr_accessor :loops, :sleep, :element_blueprints

        def loops
          @loops ||= 30
        end

        def sleep
          @sleep ||= 1
        end

        # @return [Boolean] run success or not
        def run
          element = nil

          self.blue_prints.hook_order.each { |requirement_name|
            case requirement_name
              when :exists?
              else
            end
          }
        end
      end
    end
  end
end