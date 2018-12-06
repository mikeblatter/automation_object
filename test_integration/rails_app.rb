# frozen_string_literal: true

# Run rails app everytime and clean up
require 'rest-client'

class RailsApp
  PORT = 3024
  HOST = "http://localhost:#{PORT}"
  BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'rails_app/'))

  def initialize
    create

    at_exit do
      begin
        destroy
      rescue Exception => e
        ap e
      end
    end
  end

  def create
    `cd #{BASE_DIR}; bundle install`
    `cd #{BASE_DIR}; bundle exec rake db:create`
    `cd #{BASE_DIR}; bundle exec rake db:migrate`

    @pid = Process.spawn("cd #{BASE_DIR}; bundle exec rails s -p #{PORT} > /dev/null 2>&1")

    10.times do
      sleep(5)

      begin
        RestClient.get(HOST)
        return
      rescue Exception => e
      end
    end

    raise 'Could not create server'
  end

  def destroy
    return unless @pid

    begin
      `kill $(lsof -t -i:3000)`
      puts 'Killed all processes'
      @pid = nil
    rescue Exception => e
    end
  end
end
