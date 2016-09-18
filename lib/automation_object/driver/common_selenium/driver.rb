require_relative '../driver'

module AutomationObject
  module Driver
    module CommonSelenium
      # Common Selenium/AppiumMethods
      module Driver
        # @return [Point] x,y scroll position
        def scroll_position
          position = Point.new

          position.x = @subject.execute_script('var doc = document.documentElement; return (window.pageXOffset || doc.scrollLeft) - (doc.clientLeft || 0);').to_f
          position.y = @subject.execute_script('var doc = document.documentElement; return (window.pageYOffset || doc.scrollTop) - (doc.clientTop || 0);').to_f

          position
        end

        # @return [Float] inner window height
        def inner_window_height
          @subject.execute_script('return window.innerHeight;').to_f
        end

        # @param script [String] JS to run
        # @return [Object, nil]
        def execute_script(script)
          @subject.execute_script(script)
        end

        # Go back
        # @return [void]
        def back
          @subject.navigate.back
        end

        # Go forward
        # @return [void]
        def forward
          @subject.navigate.forward
        end

        # Refresh window
        # @return [void]
        def refresh
          @subject.navigate.refresh
        end
      end
    end
  end
end
