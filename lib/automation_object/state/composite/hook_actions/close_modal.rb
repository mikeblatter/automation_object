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

          modal = composite.parent
          modal.active = modal.live?

          return false unless modal.active?

          composite.screen.modal = nil
          composite.screen.current_modal = nil
          composite.top.destroy_modal

          true
        end
      end
    end
  end
end
