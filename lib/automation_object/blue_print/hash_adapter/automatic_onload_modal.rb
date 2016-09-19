# frozen_string_literal: true
# Require parent class
require_relative 'composite'

module AutomationObject
  module BluePrint
    module HashAdapter
      # Automatic Onload Modal Composite
      class AutomaticOnloadModal < Composite
        # Validations
        validates :modal_name, instance_of: [String, Symbol], modal_presence_of: true, presence_of: true
        validates :number_of_checks, instance_of: Numeric
        validates :close, instance_of: TrueClass

        def modal_name
          modal_name = hash[:modal_name]

          case modal_name
          when Symbol, String
            return modal_name.to_sym
          else
            return nil
          end
        end

        def number_of_checks
          hash[:number_of_checks] ||= 1
        end

        def close
          hash[:close] ||= false
        end
      end
    end
  end
end
