module AutomationObject
  module Driver
    module State
      class NoInitialScreenError < StandardError; end

      class ScreenDoesNotExistError < StandardError; end
    end
  end
end