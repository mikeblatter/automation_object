#Require parent class
require_relative 'composite'

module AutomationObject::BluePrint::HashAdapter
  #Hook Element Requirements-level composite
  class HookElementRequirements < Composite

    #Valdiations
    validates :element_name, presence_of: true, instance_of: [String, Symbol], element_presence_of: true
    validates :exists?, presence_of: true, instance_of: [FalseClass, TrueClass]

    #Get the order to run the hook in
    # @return [Array<Symbol>] list of hook methods to run in given order
    def hook_order
      hook_order = [:exists?] #Always put exists? first

      self.hash.keys.each { |hook_name|
        hook_order.push(hook_name) unless [:element_name, :exists?].include?(hook_name)
      }

      return hook_order
    end

    #Get element requirement
    # @param name [Symbol] name of requested requirement
    def requirement(name)
      return self.hash[name] ||= nil
    end

    #Get name of the element
    # @return [Symbol] name of element
    def element_name
      element_name = self.hash[:element_name]

      case element_name
        when Symbol, String
          return element_name.to_sym
        else
          return nil
      end
    end
  end
end