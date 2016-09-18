require_relative 'action_loop'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      class CloseModal < ActionLoop
        def single_run
          return false unless self.driver.document_complete?

          unless self.composite.parent.is_a?(Modal)
            raise ModalParentExpected.new
          end

          modal = self.composite.parent
          modal.active = modal.live?

          if !modal.active?
            self.composite.screen.modal = nil
            self.composite.screen.current_modal = nil
            self.composite.top.destroy_modal()
            return true
          else
            return false
          end
        end
      end
    end
  end
end