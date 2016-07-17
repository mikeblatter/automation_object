#Require parent class
require_relative 'composite'

#Require child classes
require_relative 'hook'
require_relative 'custom_method'

#Require helpers
require_relative 'helpers/element_helper'
require_relative 'helpers/multiple_elements_helper'

module AutomationObject::BluePrint::HashAdapter
  #Element group composite
  class ElementGroup < Composite
    include ElementHelper
    include MultipleElementsHelper

<<<<<<< HEAD
=======
    before_create :method_hooks

>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
    #Relationships
    has_one :load, interface: Hook
    has_many :custom_methods, interface: CustomMethod

    #Validations
    validates :load, instance_of: Hash
    validates :custom_methods, instance_of: Hash
  end
end