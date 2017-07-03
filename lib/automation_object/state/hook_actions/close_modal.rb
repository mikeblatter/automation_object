# frozen_string_literal: true

require_relative 'action_loop'
require_relative '../_error'

module AutomationObject
  module State
    # Close modal hook loop
    class CloseModal < ActionLoop
      def single_run
        return false unless driver.document_complete?

        raise ModalParentExpected unless composite.parent.is_a?(Modal)

        return false if modal.live? == false

        modal.deactivate
        true
      end
    end
  end
end
