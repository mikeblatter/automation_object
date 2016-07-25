require_relative 'action_loop'

module AutomationObject
  module State
    module BluePrintAdapter
      class PossibleScreenChanges < ActionLoop
        def single_run
          self.blue_prints.each { |possible_screen_name|
            new_screen = self.composite.top.screens[possible_screen_name]
            if possible_screen_name.load.live?
              self.composite.top.set_screen(possible_screen_name)
              return true
            end
          }

          return false
        end
      end
    end
  end
end