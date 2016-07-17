module AutomationObject
<<<<<<< HEAD
  module Driver
    module State
      class NoInitialScreen < StandardError; end
    end
=======
  module State
    class UndefinedLoadTypeError < StandardError; end
    class NoInitialScreenError < StandardError; end
    class ScreenNotLiveError < StandardError; end
    class ScreenNotLiveError < StandardError; end
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
  end
end