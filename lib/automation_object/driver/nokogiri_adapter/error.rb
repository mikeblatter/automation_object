# frozen_string_literal: true
module AutomationObject
  module Driver
    # Emulate Selenium errors
    # http://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Error
    module NokogiriAdapter
      # Web driver error
      class WebDriverError < StandardError
      end

      # Element doesn't exist error
      class NoSuchElementError < WebDriverError
      end

      # No window when switching error
      class NoSuchWindowError < WebDriverError
      end

      # Document doesn't exist
      class NoSuchDocumentError < WebDriverError
      end

      # Can't navigate forward
      class UnableToNavigateForward < WebDriverError
        def initialize(message = 'Cannot navigate forward')
          super
        end
      end

      # Can't navigate backward
      class UnableToNavigateBackward < WebDriverError
        def initialize(message = 'Cannot navigate backward')
          super
        end
      end
    end
  end
end
