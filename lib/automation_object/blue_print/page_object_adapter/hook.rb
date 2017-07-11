# frozen_string_literal: true

require_relative 'composite'

require_relative 'hook_element_requirements'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Hook composite
      class Hook < Composite
        # @return [Array<HookElementRequirements>] array of element requirements
        def live?
          return @live if defined? @live

          children = get_property(:live?)
          children = children.is_a?(Array) ? children : []

          @live = create_array_children(:live, children,
                                        interface: HookElementRequirements,
                                        location: location + '[live?]')
          @live
        end
      end
    end
  end
end
