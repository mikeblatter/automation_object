#Require parent class
require_relative 'composite'
require_relative 'hook_element_requirements'

module AutomationObject::BluePrint::HashAdapter
  #Hook action composite
  class HookAction < Composite
    #Call the wait_for_elements method to generate the children
    before_create :wait_for_elements

    #Validations
    validates_keys allowed_keys: [:new_screen, :show_modal, :close_screen, :change_screen,
                  :sleep, :wait_for_elements, :change_to_previous_screen, :close_modal, :reset_screen,
                  :possible_screen_changes]

    validates :change_screen, instance_of: [String, Symbol], screen_presence_of: true
    validates :new_screen, instance_of: [String, Symbol], screen_presence_of: true
    validates :change_to_previous_screen, instance_of: TrueClass
    validates :close_modal, instance_of: TrueClass
    validates :close_screen, instance_of: TrueClass
    validates :possible_screen_changes, instance_of: String, screen_presence_of: true
    validates :reset_screen, instance_of: TrueClass
    validates :show_modal, instance_of: String, modal_presence_of: true
    validates :sleep, instance_of: Numeric
    validates :wait_for_elements, instance_of: Array

    #Get the order to run the hook in
    # @return [Array<Symbol>] list of hook methods to run in given order
    def hook_order
      return self.hash.keys
    end

    #Get length of hook actions
    # @return [Integer] length of hook actions
    def length
      return self.hash.keys.length
    end

    #See if hook actions are empty
    # @return [Boolean] if hook actions are empty
    def empty?
      return !(self.hash.keys.length > 0)
    end

    # @return [Symbol, nil] screen to change to
    def change_screen
      change_screen = self.hash[:change_screen]

      case change_screen
        when Symbol, String
          return change_screen.to_sym
        else
          return nil
      end
    end

    # @return [Symbol, nil] new screen
    def new_screen
      new_screen = self.hash[:new_screen]

      case new_screen
        when Symbol, String
          return new_screen.to_sym
        else
          return nil
      end
    end

    # @return [Boolean]
    def close_screen
      return self.hash[:close_screen] ||= false
    end

    # @return [Boolean]
    def close_modal
      return self.hash[:close_modal] ||= false
    end

    # @return [Boolean]
    def change_to_previous_screen
      return self.hash[:change_to_previous_screen] ||= false
    end

    # @return [Symbol, nil]
    def show_modal
      show_modal = self.hash[:show_modal]

      case show_modal
        when Symbol, String
          return show_modal.to_sym
        else
          return nil
      end
    end

    # @return [Array]
    def possible_screen_changes
      if self.hash[:possible_screen_changes].is_a?(Array)
        return self.hash[:possible_screen_changes].map { |value| value.to_sym }
      else
        return Array.new
      end
    end

    #@return [Boolean] reset the screen?
    def reset_screen
      return self.hash[:reset_screen] ||= false
    end

    #@return [Numeric] amount of time to sleep
    def sleep
      return self.hash[:sleep] ||= 0
    end

    #Custom method for array of children instead of Hash
    # @return [Array<HookElementRequirements>] array of wait for element children
    def wait_for_elements
      return @wait_for_elements if @wait_for_elements
      wait_for_elements = self.hash[:wait_for_elements]

      children = (wait_for_elements.is_a?(Array)) ? wait_for_elements : Array.new
      @wait_for_elements = self.create_array_children(children,
                                                      { interface: HookElementRequirements,
                                                        location: self.location + '[wait_for_elements]'
                                                      })

      return @wait_for_elements
    end
  end
end