require_relative 'action_loop'
require_relative '../modal'
require_relative '../../error'

module AutomationObject
  module State
    module BluePrintAdapter
      class CloseModal < ActionLoop
        def single_run
          self.driver.document_complete_wait

          unless self.composite.parent.is_a?(Modal)
            raise ModalParentExpected.new
          end

          modal = self.composite.parent
          modal.active = modal.live?

          return (model.active?) ? false : true
        end
      end
    end
  end
end