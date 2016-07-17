#Require parent class
require_relative 'composite'

#Require child classes
require_relative 'hook'
require_relative 'custom_method'

#Require helpers
require_relative 'helpers/element_helper'
require_relative 'helpers/multiple_elements_helper'

module AutomationObject::BluePrint::HashAdapter
  #Element hash composite
  class ElementHash < Composite
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
<<<<<<< HEAD
=======

>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
    validates :define_elements_by, instance_of: [String, Symbol], presence_of: true
    validates :custom_range, instance_of: [Hash, String]
    validates :in_iframe, instance_of: String, element_presence_of: true
    validates :custom_methods, instance_of: Hash
    validates :css, instance_of: String, presence_of: { :unless_presence_of => :xpath }
    validates :xpath, instance_of: String, presence_of: { :unless_presence_of => :css }

    # @return [Symbol] element method to define element keys by
    def define_elements_by
      return self.hash[:define_elements_by].to_sym
    end
  end
end