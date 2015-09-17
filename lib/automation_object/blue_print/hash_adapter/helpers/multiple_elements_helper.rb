module AutomationObject::BluePrint
  module HashAdapter
    #Helper module for multiple element composite classes
    module MultipleElementsHelper
      # @return [Range, nil] gives range for limiting multiple elements or nil
      def custom_range
        custom_range = self.hash[:custom_range]

        case custom_range
          when String
            integer_array = custom_range.split('..').map { |number| Integer(number) }
            return integer_array[0]..integer_array[1]
          when Hash
            return custom_range[:start].to_i..custom_range[:end].to_i
        end

        return nil
      end

      # @return [Symbol, nil] gives element method to remove duplicates on or nil
      def remove_duplicates
        remove_duplicates = self.hash[:remove_duplicates]

        case remove_duplicates
          when Symbol, String
            return remove_duplicates.to_sym
          else
            return nil
        end
      end
    end
  end
end