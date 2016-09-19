# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      # Reset screen hook loop
      class ResetScreen < ActionLoop
        def single_run
        end
      end
    end
  end
end
