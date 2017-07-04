# frozen_string_literal: true

# Require parent class
require_relative 'base'

require_relative 'automatic_modal_change'
require_relative 'hook'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

require_relative 'helpers/container_helper'

module AutomationObject
  module BluePrint
    module Composite
      # Modal composite class
      class Modal < Base
        include ContainerHelper
      end
    end
  end
end
