require_relative 'action_loop'

module AutomationObject
  module State
    module BluePrintAdapter
      class ShowModal < ActionLoop
        def initialize(args = {})
          super
          @new_modal_name = args.fetch :blue_prints
        end

        def single_run
          new_modal = self.composite.screen.modals[@new_modal_name]

          if new_modal.load.live? != false
            self.composite.screen.current_modal = @new_modal_name
            self.composite.screen.modal = new_modal
            return true
          else
            return false
          end
        end
      end
    end
  end
end