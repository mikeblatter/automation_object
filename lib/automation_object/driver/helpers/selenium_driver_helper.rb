module AutomationObject
  module Driver
    #Helper module for Selenium based drivers
    #for use by SeleniumAdapter::Driver and AppiumAdapter::Driver
    module SeleniumDriverHelper
      # @return [Float] inner window height
      def inner_window_height
        @subject.execute_script('return window.innerHeight;').to_f
      end

      # @return [Hash] x,y scroll position
      def scroll_position
        position = OpenStruct.new

        position.x = @subject.execute_script('var doc = document.documentElement; return (window.pageXOffset || doc.scrollLeft) - (doc.clientLeft || 0);').to_f
        position.y = @subject.execute_script('var doc = document.documentElement; return (window.pageYOffset || doc.scrollTop) - (doc.clientTop || 0);').to_f

        return position
      end

      def scroll_position=(position)
        @subject.execute_script("window.scroll(#{position[:x]},#{position[:y]});")
      end

      # @param window_dimension [Hash] :width, :height of window
      def window_size=(window_dimension)
        @subject.manage.window.resize_to(window_dimension[:width], window_dimension[:height])
      end

      # @return [Hash] :width, :height of window
      def window_size
        @subject.manage.window.size
      end

      #Maximize the current window
      def maximize_window
        @subject.manage.window.maximize
      end
    end
  end
end