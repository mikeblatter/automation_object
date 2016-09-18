module AutomationObject
  # Hooks for composites
  module CompositeHook
    def before_create_run
      self.class.before_create_hooks.each do |before_create_hook|
        send(before_create_hook)
      end
    end

    def after_create_run
      self.class.after_create_hooks.each do |after_create_hook|
        send(after_create_hook)
      end
    end

    # @param base [Class] class to extend when included
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Class level methods
    module ClassMethods
      # @param instance_method [Symbol] method to call
      def after_create(instance_method)
        after_create_hooks.push(instance_method)
      end

      # @return [Array<Symbol>] list of methods to call
      def after_create_hooks
        @after_create_hooks = [] unless defined? @after_create_hooks
        @after_create_hooks
      end

      # @param instance_method [Symbol] method to call
      def before_create(instance_method)
        before_create_hooks.push(instance_method)
      end

      # @return [Array<Symbol>] list of methods to call
      def before_create_hooks
        @before_create_hooks = [] unless defined? @before_create_hooks
        @before_create_hooks
      end
    end
  end
end
