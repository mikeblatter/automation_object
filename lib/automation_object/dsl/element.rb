require_relative '_proxy'

module AutomationObject
  module Dsl
    class ElementProxy < Proxy
      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        #If subject is null, then load it
        if @subject == nil
          @subject = @state.load(:element, @name)
        end

        super
      end
    end
  end
end