# frozen_string_literal: true

require 'rest-client'
require 'nokogiri'

require_relative 'request'
require_relative 'error'

module AutomationObject
  module Driver
    module NokogiriAdapter
      # Window class
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
          make_request(request)

          update_history(request)
        end

        # @return [String]
        def current_url
          request = @history.at(@position)
          !request.nil? ? request.url : nil
        end

        # @return [void]
        def back
          raise UnableToNavigateBackward if @position.zero?

          @position -= 1

          make_request(@history.at(@position))
        end

        # @return [void]
        def forward
          raise UnableToNavigateForward if @position >= @history.length - 2

          @position += 1

          make_request(@history.at(@position))
        end

        # @return [void]
        def refresh
          make_request(@history.at(@position))
        end

        protected

        # @return [void]
        def update_history(request)
          @history.push(request)
          @position = @history.length - 1
        end

        # Request url, will set xml to current window handle
        # @param request [Request] request object
        # @return [void]
        def make_request(request)
          parsed_url = request.url

          raise ArgumentError, "Expecting get argument url to be a valid_url?, got #{request.url}" if !parsed_url.valid_url? && current_url.nil?

          parsed_url = current_url.join_url(request.url) if !request.url.valid_url? && !current_url.nil?

          client_resource = RestClient::Resource.new(parsed_url, ssl_version: 'SSLv23_client')
          response = client_resource.send(request.type, params: request.params)

          self.xml = Nokogiri::HTML.parse(response)
        end
      end
    end
  end
end
