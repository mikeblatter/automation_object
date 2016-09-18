require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      class CloseModal < ActionLoop
        def single_run
          return false unless driver.document_complete?

          raise ModalParentExpected unless composite.parent.is_a?(Modal)

          modal = composite.parent
          modal.active = modal.live?

          if !modal.active?
            composite.screen.modal = nil
            composite.screen.current_modal = nil
            composite.top.destroy_modal
            return true
          else
            return false
          end
        end
      end
    end
  end
end
