module AutomationObject::Dsl
  module Proxies
    #CompositeHelper for DSL Proxies
    #Proxies will deal with the State and wrap around the models
    module CompositeHelper
      attr_accessor :state

      # @param state [AutomationObject::State::Controller]
      def state=(state)
        @state = state
        self.children.each { |child|
          @subject[child].state = @state
        }
      end

      # @return [Array] hooks array or empty array
      def hooks
        @hooks ||= Array.new
      end

      # @return [Hash] composite hooks or empty hash
      def composite_hooks
        @composite_hooks ||= Hash.new
      end

      # @return [Array] children array or empty array
      def children
        @children ||= Array.new
      end

      # Use this to add children to the DSL composite
      # @param args [Hash] arguments for adding a child to this composite
      def add(args={})
        name = args.fetch :name
        @subject[name] = args.fetch :object
        self.children.push(name)

        type = args.fetch(:type)

        case type
          when :screen, :modal
            #Just load
            self.composite_hooks[name] = lambda { self.request_load(type, name) }
          when :element, :element_array, :element_hash, :element_group
            #Set return to subject
            self.composite_hooks[name] = lambda { @subject[name] = self.request_load(type, name) }
        end

        @subject[name].hooks.push(self.composite_hooks[name]) if self.composite_hooks.has_key?(name)
        return @subject[name]
      end

      # Request the state to load an object
      # @param type [Symbol] type of object (:screen, :modal, :element, :etc...)
      # @param name [Symbol] name of the object
      def request_load(type, name)
        @state.load(type, name)
      end

      #Override to allow for hooks to be run when using the DSL API
      def method_missing(method_symbol, *args, &block)
        return super unless self.children.include?(method_symbol)

        self.hooks.each { |hook| hook.call }

        if self.composite_hooks.has_key?(method_symbol)
          self.composite_hooks[method_symbol].call
        end

        super
      end
    end
  end
end