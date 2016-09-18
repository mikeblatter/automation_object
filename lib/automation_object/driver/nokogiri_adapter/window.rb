require 'rest-client'
require 'nokogiri'

require_relative 'request'
require_relative 'error'

module AutomationObject
  module Driver
    module NokogiriAdapter
      class Window
        attr_accessor :handle, :xml

        def initialize
          self.handle = SecureRandom.hex(16)

          # Use to control history
          @position = 0
          @history = []
        end

        # Get url, will set xml to current window handle
        # @param url [String] url to get xml for
        # @return [Object] nokogiri object
        def request(type, url, params = {})
          request = Request.new(type, url, params)
          self.make_request(request)

          self.update_history(request)
        end

        def current_url
          request = @history.at(@position)
          return request.url
        end

        def back
          raise UnableToNavigateBackward.new if @position == 0
          @position -= 1

          self.make_request(@history.at(@position))
        end

        def forward
          raise UnableToNavigateForward.new if @position >= @history.length - 2
          @position += 1

          self.make_request(@history.at(@position))
        end

        def refresh
          self.make_request(@history.at(@position))
        end

        protected

        def update_history(request)
          @history.push(request)
          @position = @history.length - 1
        end

        # Request url, will set xml to current window handle
        # @param request [Request] request object
        def make_request(request)
          parsed_url = request.url

          if parsed_url.valid_url? == false and self.current_url == nil
            raise ArgumentError, "Expecting get argument url to be a valid_url?, got #{url}"
          elsif url.valid_url? == false and self.current_url
            parsed_url = self.current_url.join_url(request.url)
          end

          client_resource = RestClient::Resource.new(parsed_url, :ssl_version => 'SSLv23_client')
          response = client_resource.send(request.type, {:params => request.params})

          self.xml = Nokogiri::HTML.parse(response)
        end
      end
    end
  end
end
