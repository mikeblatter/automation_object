module AutomationObject
  module State
    module AutomationObject
      module State
        class CannotNavigateBack < StandardError
          def initialize(message = 'Cannot navigate backwards in history')
            super
          end
        end

        class CannotNavigateForward < StandardError
          def initialize(message = 'Cannot navigate forwards in history')
            super
          end
        end
      end
    end
  end
end