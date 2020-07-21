class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [ :create, :search ]
  before_action :set_user, only: [:update, :destroy, :show]

  # GET /users
  def index
    @users = User.all_full_info
    json_response(@users)
  end

  # POST /users
  def create
    user = User.create!(user_params)
    UserInfo.create!(user_info_params.merge({user_id: user.id}))
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # GET /users/me/profile
  def show_me
    json_response(current_user.full_info)
  end

  # GET /users/:id
  def show
    json_response(@user.full_info)
  end

  # PUT /users/:id
  def update
    @user.update(user_params)
    @user.user_info.update(user_info_params)
    head :no_content
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  # GET /users/search/:search
  def search
    @users = UserInfo.search(params[:search])
    json_response(@users)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :isPremium, :isBan)
  end

  def user_info_params
    params.permit( :username, :firstname, :lastname, :quote, :profile_picture)
  end

  def set_user
    @user = User.find(params[:id])
  end
end