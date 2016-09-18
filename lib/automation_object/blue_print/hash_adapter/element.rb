# Require parent class
require_relative 'composite'

# Require child classes
require_relative 'hook'
require_relative 'custom_method'

# Require helpers
require_relative 'helpers/element_helper'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Element composite
      class Element < Composite
        include ElementHelper

        before_create :method_hooks

        # Relationships
        has_one :load, interface: Hook
        has_many :custom_methods, interface: CustomMethod

        # Validations
        validates :load, instance_of: Hash
        validates :custom_methods, instance_of: Hash

        validates :in_iframe, instance_of: String, element_presence_of: true
        validates :css, instance_of: String, presence_of: { unless_presence_of: :xpath }
        validates :xpath, instance_of: String, presence_of: { unless_presence_of: :css }
      end
    end
  end
end
