module AutomationObject
  module BluePrint
    module HashAdapter
      #HookHelper for composite hooks
      module HookHelper
        def before_create_run
          self.class.before_create_hooks.each { |before_create_hook|
            self.send(before_create_hook)
          }
        end

        def after_create_run
          self.class.after_create_hooks.each { |after_create_hook|
            self.send(after_create_hook)
          }
        end

        # @param base [Class] class to extend when included
        def self.included(base)
          base.extend(ClassMethods)
        end

        #Class level methods
        module ClassMethods
          # @param instance_method [Symbol] method to call
          def after_create(instance_method)
            self.after_create_hooks.push(instance_method)
          end

          # @return [Array<Symbol>] list of methods to call
          def after_create_hooks
            @after_create_hooks = [] unless @after_create_hooks
            return @after_create_hooks
          end

          # @param instance_method [Symbol] method to call
          def before_create(instance_method)
            self.before_create_hooks.push(instance_method)
          end

          # @return [Array<Symbol>] list of methods to call
          def before_create_hooks
            @before_create_hooks = [] unless @before_create_hooks
            return @before_create_hooks
          end
        end
      end
    end
  end
end