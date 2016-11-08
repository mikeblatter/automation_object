# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      # Possible screen changes hook loop
      class PossibleScreenChanges < ActionLoop
        def single_run
          blue_prints.each do |possible_screen_name|
            if possible_screen_name.load.live? != false
              composite.top.window.update(possible_screen_name)
              return true
            end
          end

          false
        end
      end
    end
  end
end
