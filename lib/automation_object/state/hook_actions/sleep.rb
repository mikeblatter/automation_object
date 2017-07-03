# frozen_string_literal: true

require_relative 'action_loop'

module AutomationObject
  module State
    # Sleep hook loop
    class Sleep < ActionLoop
      def single_run
        sleep(blue_prints)
      end
    end
  end
end
