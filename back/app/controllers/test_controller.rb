class TestController < ApplicationController
  def ping
    json_response 'pong', 200
  end
end
