# frozen_string_literal: true

# Require parent class
require_relative 'base'

require_relative 'automatic_modal_change'
require_relative 'hook'

require_relative 'modal'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

require_relative 'helpers/container_helper'

module AutomationObject
  module BluePrint
    module Composite
      # Screen composite class
      class Screen < Base
        include ContainerHelper

        # @return [Array<AutomationObject::BluePrint::Composite::AutomaticModalChange>]
        def automatic_modal_changes
          adapter.automatic_modal_changes
        end

        # @return [Array<Symbol>]
        def automatic_screen_changes
          adapter.automatic_screen_changes
        end

        # @return [AutomationObject::BluePrint::Composite::Hook]
        def accept
          adapter.accept
        end

        # @return [AutomationObject::BluePrint::Composite::Hook]
        def dismiss
          adapter.dismiss
        end

        # @return [Hash<AutomationObject::BluePrint::Composite::Modal>]
        def modals
          adapter.modals
        end
      end
    end
  end
end
