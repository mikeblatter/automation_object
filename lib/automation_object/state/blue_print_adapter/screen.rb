require_relative 'composite'

require_relative 'hook'
require_relative 'modal'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_group'
require_relative 'element_hash'

module AutomationObject
  module State
    module BluePrintAdapter
      class Screen < Composite
        has_one :load, interface: Hook

        #Children for this composite
        has_many :modals, interface: Screen

        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_groups, interface: ElementGroup
        has_many :element_hashes, interface: ElementHash
<<<<<<< HEAD
=======

        attr_accessor :active
        # @return [Boolean] screen is active or not
        def active
          return @active ||= false
        end
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end