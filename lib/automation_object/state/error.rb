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

        class UnexpectedExtraWindowError < StandardError
          def initialize(message = 'Expecting only 1 extra window handle')
            super
          end
        end

        class UndefinedLoadTypeError < StandardError;
        end

        class NoInitialScreenError < StandardError
          def initialize(message = 'No initial screen to be set to')
            super
          end
        end

        class ScreenNotActiveError < StandardError
          def initialize(screen)
            message = "#{screen} is not currently active"
            super(message)
          end
        end

        class ModalNotActiveError < StandardError; end
        class ModalParentExpected < StandardError; end
        class ScreenParentExpected < StandardError; end
        class MoreThenOneScreenCreated < StandardError; end
      end
    end
  end
end
