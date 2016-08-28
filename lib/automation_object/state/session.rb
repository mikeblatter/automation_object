require_relative 'window_manager'

module AutomationObject
  module State
    class Session
      include WindowManager
    end
  end
end