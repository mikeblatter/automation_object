require_relative '../action'

module AutomationObject
  module StepDefinitions
    module Element
      class CallAction < AutomationObject::StepDefinitions::Action
        def initialize(*args)
          super
          @method, @screen, @element = self.args
        end

        def run
          automation_object.send(@screen).send(@element).send(@method)
        end
      end

      class TypeAction < AutomationObject::StepDefinitions::Action
        def initialize(*args)
          super
          @text, @screen, @element = self.args
        end

        def run
          automation_object.send(@screen).send(@element).send_keys(@text)
        end
      end

      class ScrollAction < AutomationObject::StepDefinitions::Action
        def initialize(*args)
          super
          @screen, @element = self.args
        end

        def run
          automation_object.send(@screen).send(@element).scroll_into_view
        end
      end

      class SaveAction < AutomationObject::StepDefinitions::Action
        def initialize(*args)
          super
          @method, @key, @screen, @element = self.args
        end

        def run
          #Save value from called method/property
          value = automation_object.send(@screen).send(@element).send(@method)
          AutomationObject::StepDefinitions::Cache.set(@key, value)
        end
      end

      class ExistAction < AutomationObject::StepDefinitions::Action
        def initialize(*args)
          super
          @screen, @element, @negative = self.args
        end

        def run
          exists = AutomationObject::Framework.get.send(@screen).send(@element).exists?

          if @negative
            assert_equal false, exists
          else
            assert_equal true, exists
          end
        end
      end

      class EqualAction < AutomationObject::StepDefinitions::Action
        def initialize(*args)
          super
          @screen, @element, @method, @negative, @expected_value = self.args
        end

        def run
          actual_value = AutomationObject::Framework.get.send(@screen).send(@element).send(@method)

          if @negative
            refute_equal @expected_value, actual_value
          else
            assert_equal @expected_value, actual_value
          end
        end
      end
    end
  end
end