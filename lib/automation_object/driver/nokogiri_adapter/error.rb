module AutomationObject
  module Driver
    #Emulate Selenium errors
    #http://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Error
    module NokogiriAdapter
      class WebDriverError < StandardError
      end

      class NoSuchElementError < WebDriverError
      end

      class NoSuchWindowError < WebDriverError
      end

      class NoSuchDocumentError < WebDriverError
      end

      class UnableToNavigateForward < WebDriverError
        def initialize(message = 'Cannot navigate forward')
          super
        end
      end

      class UnableToNavigateBackward < WebDriverError
        def initialize(message = 'Cannot navigate backward')
          super
        end
      end
    end
  end
end