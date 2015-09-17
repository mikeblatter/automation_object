#Require parent class
require_relative 'composite'

module AutomationObject::BluePrint::HashAdapter
  #View composite, no children, merges into screens then screens will add children here
  #Helpful to have validations before merging the hashes, that way errors show in the correct place
  class View < Composite
    #Validations
    validates_keys allowed_keys: [:automatic_onload_modals, :automatic_screen_changes, :elements, :element_arrays,
                   :element_groups, :element_hashes, :included_views, :load, :modals]

    validates :automatic_onload_modals, instance_of: Array, modal_presence_of: true
    validates :automatic_screen_changes, instance_of: Array, screen_presence_of: true

    validates :elements, instance_of: Hash
    validates :element_arrays, instance_of: Hash
    validates :element_groups, instance_of: Hash
    validates :element_hashes, instance_of: Hash

    validates :included_views, instance_of: Array, view_presence_of: true

    validates :load, instance_of: Hash

    validates :modals, instance_of: Hash
  end
end