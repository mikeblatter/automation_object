#Require parent class
require_relative 'composite'

require_relative 'hook_action'
require_relative 'hook_element_requirements'

module AutomationObject
  module BluePrint
    module HashAdapter
      #Hook composite
      class Hook < Composite
        #Call the live? method so that it creates the needed Array of ElementRequirement interfaces
        before_create :live?

        #Relationships
        has_one :before, interface: HookAction
        has_one :after, interface: HookAction

        #Validations
        validates_keys allowed_keys: [:before, :live?, :after]

        # @return [Array<HookElementRequirements>] array of element requirements
        def live?
          return @live if defined? @live

          children = self.hash[:live?]
          children = (children.is_a?(Array)) ? children : Array.new

          @live = self.create_array_children(:live, children,
                                             {
                                                 interface: HookElementRequirements,
                                                 location: self.location + '[live?]'
                                             })
          return @live
        end
      end
    end
  end
end