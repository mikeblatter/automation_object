# frozen_string_literal: true
require_relative '_base'
require_relative '../error'

require_relative 'modal'
require_relative 'hook'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module State
    module Composite
      # Screen composite for managing state
      class Screen < Base
        attr_accessor :modal

        has_one :load, interface: Hook

        # Children for this composite
        has_many :modals, interface: Modal

        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash

        def use(name)
          self.modal = name
        end

        def get(type, name)
          return modals[modal].get(type, name) if modal

          case type
          when :element
            return elements[name].load
          when :element_array
            return element_arrays[name].load
          when :element_hash
            return element_hashes[name].load
          else
            raise AutomationObject::State::UndefinedLoadTypeError
          end
        end

        def reset
          elements.values.map(&:reset)
          element_arrays.values.map(&:reset)
          element_hashes.values.map(&:reset)
        end

        # Whether or not modal is active
        # @return [Boolean]
        attr_accessor :active

        undef :active if defined? :active
        # @return [Boolean] screen is active or not
        def active
          @active ||= false
        end
      end
    end
  end
end
