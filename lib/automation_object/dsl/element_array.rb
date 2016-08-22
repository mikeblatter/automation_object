require_relative '_proxy'

module AutomationObject
  module Dsl
    class ElementArrayProxy < Proxy
      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        #If subject is null, then load it
        if @subject == nil
          @subject = @state.load(:element_array, @name)
        end

        super
      end
    end
  end
end