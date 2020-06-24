class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [ :create, :search ]
  before_action :set_user, only: [:update, :destroy, :show]

  # GET /users
  def index
    @users = User.all
    json_response(@users)
  end

  # POST /users
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # GET /users/me/profile
  def show_me
    json_response(current_user)
  end

  # GET /users/:id
  def show
    json_response(@user)
  end

  # PUT /users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  # GET /users/search/:search
  def search
    @users = User.search(params[:search])
    json_response(@users)
  end

  private

  def user_params
    # whitelist params
    params.permit(:username, :firstname, :lastname, :password, :password_confirmation, :email, :isPremium, :isBan)
  end

  def set_user
    @user = User.find(params[:id])
  end
end