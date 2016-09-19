# frozen_string_literal: true
require_relative 'action_loop'

module AutomationObject
  module State
    module Composite
      class ChangeScreen < ActionLoop
        def initialize(args = {})
          super
          @new_screen_name = args.fetch :blue_prints
        end

        def single_run
          return false unless driver.document_complete?

          new_screen = composite.top.screens[@new_screen_name]
          if new_screen.load.live?
            composite.top.set_screen(@new_screen_name)
            return true
          else
            return false
          end
        end
      end
    end
  end
end
