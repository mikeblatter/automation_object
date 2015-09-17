module AutomationObject
  module Driver
    #Emulate Selenium errors
    #http://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Error
    module NokogiriAdapter
      #
      class WebDriverError < StandardError; end
      class NoSuchElementError < WebDriverError; end
      class NoSuchWindowError < WebDriverError; end
      class NoSuchDocumentError < WebDriverError; end
    end
  end
end