# frozen_string_literal: true
module AutomationObject
  module State
    # Cannot navigate back error
    class CannotNavigateBack < StandardError
      def initialize(message = 'Cannot navigate backwards in history')
        super
      end
    end

    # Cannot navigate forward error
    class CannotNavigateForward < StandardError
      def initialize(message = 'Cannot navigate forwards in history')
        super
      end
    end

    # More than one expected new windows
    class UnexpectedExtraWindowError < StandardError
      def initialize(message = 'Expecting only 1 extra window')
        super
      end
    end

    # Undefined load type called on the State object
    class UndefinedLoadTypeError < StandardError
    end

    # No initial screen to start from
    class NoInitialScreenError < StandardError
      def initialize(message = 'No initial screen to be set to')
        super
      end
    end

    # Screen is not currently active
    class ScreenNotActiveError < StandardError
      def initialize(screen)
        message = "#{screen} is not currently active"
        super(message)
      end
    end

    # Modal isn't active error
    class ModalNotActiveError < StandardError;
    end

    # Modal parent error
    class ModalParentExpected < StandardError;
    end

    # Screen parent error
    class ScreenParentExpected < StandardError;
    end

    # More than one screen created error
    class MoreThenOneScreenCreated < StandardError;
    end

    class NoActiveWindows < StandardError;
    end
  end
end
