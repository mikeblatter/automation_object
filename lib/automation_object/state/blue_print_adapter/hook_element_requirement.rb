module AutomationObject
  module State
    module BluePrintAdapter
      class HookElementRequirement < Composite
        def initialize(args = {})
          @blue_prints = args.fetch(:blue_prints)
          @session = args.fetch(:session)
          @loops = args.fetch(:loops, 30)
        end

        # @return [AutomationObject::Driver::Element]
        def element
          @element ||= @session.find_element(*@blue_prints.element_blueprints.selector_params)
        end

        # @return [Boolean] run success or not
        def run
          @blue_prints.hook_order.each { |requirement_name|
            next if @blue_prints.requirement(requirement_name) == nil

            requirement_value = @blue_prints.requirement(requirement_name)

            case requirement_name
              when :exists?
                if requirement_value != @session.exists?(*@blue_prints.element_blueprints.selector_params)
                  return false
                end
              else
                if requirement_value != self.element.send(requirement_name)
                  return false
                end
            end
          }

          return true
        end
      end
    end
  end
end