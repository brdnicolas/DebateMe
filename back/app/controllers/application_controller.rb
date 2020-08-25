class ApplicationController < ActionController::API
  include Response
  include Exceptions

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
    json_response({ error: 'Bannis' }, :unauthorized_request) if @current_user.isBan
    @current_user.check_achievements if rand(10) >= 7
  end

end
