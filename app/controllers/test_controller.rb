class TestController < ApplicationController
  def ping
    render :json => 'pong'
  end
end