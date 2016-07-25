#Require parent class
require_relative 'composite'

#Require child classes
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'
require_relative 'hook'

module AutomationObject
  module BluePrint
    module HashAdapter
      #Modal-level composite, ActiveRecord style composite implementation inheriting from Composite
      class Modal < Composite
        #Relationships
        has_one :load, interface: Hook

        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash

        #Validations
        validates_keys allowed_keys: [:load, :elements, :element_arrays, :element_hashes]

        validates :load, instance_of: Hash
        validates :elements, instance_of: Hash
        validates :element_arrays, instance_of: Hash
        validates :element_hashes, instance_of: Hash
      end
    end
  end
end