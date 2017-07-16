# frozen_string_literal: true

module AutomationObject
  module Dsl
    # Errors related to interacting with the DSL
    module Error
      # Error for non-existent screen
      class ScreenDoesNotExistError < StandardError
        # @param name [Symbol,String] screen name
        def initialize(name)
          message = "#{name} screen does not exist"
          super(message)
        end
      end

      # Error for non-existent element
      class ElementDoesNotExistError < StandardError
        # @param name [Symbol,String] element name
        def initialize(name)
          message = "#{name} element does not exist"
          super(message)
        end
      end

      # Error for non-existent element hash
      class ElementHashDoesNotExistError < StandardError
        # @param name [Symbol,String] element hash name
        def initialize(name)
          message = "#{name} element hash does not exist"
          super(message)
        end
      end

      # Error for non-existent element array
      class ElementArrayDoesNotExistError < StandardError
        # @param name [Symbol,String] element array name
        def initialize(name)
          message = "#{name} element array does not exist"
          super(message)
        end
      end
    end
  end
end
