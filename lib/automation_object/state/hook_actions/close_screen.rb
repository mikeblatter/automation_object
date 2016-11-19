# frozen_string_literal: true
require_relative 'action_loop'
require_relative '../_error'

module AutomationObject
  module State
    # Close screen hook loop
    class CloseScreen < ActionLoop
      def single_run
        raise ScreenParentExpected unless composite.screen

        return false unless composite.screen.closed?

        composite.screen.deactivate

        true
      end
    end
  end
end
