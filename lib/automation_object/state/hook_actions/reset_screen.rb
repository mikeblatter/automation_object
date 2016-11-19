# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    # Reset screen hook loop
    class ResetScreen < ActionLoop
      def single_run
        composite.screen.reset
      end
    end
  end
end
