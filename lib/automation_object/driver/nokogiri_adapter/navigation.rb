module AutomationObject
  module Driver
    module NokogiriAdapter
      module Navigation
        # Navigates current window to a given url
        # @param url [String] navigate to the following url
        # @return [void]
        def get(url)
          self.session.get(url)
        end

        def back
          self.session.back
        end

        def forward
          self.session.forward
        end

        def close

        end
      end
    end
  end
end