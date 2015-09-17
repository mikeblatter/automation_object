module AutomationObject::Driver::NokogiriAdapter
  #Element class for Nokogiri/XML
  class Element < AutomationObject::Proxies::Proxy
    def initialize(args)
      @driver = args.fetch :driver
      @subject = args.fetch :element
    end

    # @return [String] id of element
    def id
      @subject['id']
    end

    # @return [String] href of element
    def href
      @subject['href']
    end

    # @return [Boolean] content of element
    def content
      @subject['content']
    end

    def attribute(key, value = nil)
      @subject[key] = value if value
      return @subject[key]
    end

    def click
      url = self.href
      if self.attribute('target') == '_blank'
        @driver.new_window
      end

      @driver.get(url)
    end
  end
end