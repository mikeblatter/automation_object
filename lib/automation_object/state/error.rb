module AutomationObject
  module State
    class UndefinedLoadTypeError < StandardError; end
    class NoInitialScreenError < StandardError; end
    class ScreenDoesNotExistError < StandardError; end
  end
end