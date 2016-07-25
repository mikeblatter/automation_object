#Require parent class
require_relative 'composite'

module AutomationObject
  module BluePrint
    module HashAdapter
      #Custom method composite
      class CustomMethod < Composite
        #Validations
        validates :element_method, instance_of: [String, Symbol], presence_of: true
        validates :evaluate, instance_of: [String], presence_of: true

        def element_method
          element_method = self.hash[:element_method]

          case element_method
            when Symbol, String
              return element_method.to_sym
            else
              return nil
          end
        end

        def evaluate
          return self.hash[:evaluate] ||= nil
        end
      end
    end
  end
end