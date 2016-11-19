# frozen_string_literal: true
require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      # Close modal hook loop
      class CloseModal < ActionLoop
        def single_run
          return false unless driver.document_complete?

          raise ModalParentExpected unless composite.parent.is_a?(Modal)

          return false if modal.live?

          composite.screen.modal = nil
          true
        end
      end
    end
  end
end
