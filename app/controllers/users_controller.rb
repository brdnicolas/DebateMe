class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [ :create, :search, :show ]
  before_action :set_user, only: [:update, :destroy, :show, :show_achievements, :show_activities]

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
    json_response(current_user.complete_profile)
  end

  # GET /users/:id
  def show
    json_response(@user.complete_profile)
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

  def user_pay
    Stripe.api_key = 'sk_test_51H0icEEfP5i1LDx8OJXaM7sUcckxNisoWOARRdwuPxGbWJxnVkH9FAIcu177cgHPB1tb6CqQ0wY3cwQhf40D8cqk00g00NEeGQ'
    session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
                         price: 'price_1HH8WLEfP5i1LDx8jZu9mHPl',
                         quantity: 1,
                     }],
        mode: 'subscription',
        success_url: 'https://pli.hugovast.tech/me',
        cancel_url: 'https://pli.hugovast.tech/home',
        )
  end

  def set_premium
    current_user.update!(isPremium: 1)
    redirect_to 'https://pli.hugovast.tech/home'
  end

  # GET /users/search/:search
  def search
    @users = UserInfo.search(params[:search])
    json_response(@users)
  end

  # GET /users/:id/achievements
  def show_achievements
    json_response @user.user_info.get_achievements
  end

  # GET /users/:id/activity
  def show_activities
    posts, answer = @user.posts.partition { |post| post.subpost_id.nil? }
    json_response({ posts: posts, answer: answer })
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :isPremium, :isBan)
  end

  def user_info_params
    params.permit( :username, :firstname, :lastname, :quote, :profile_picture, :banner)
  end

  def set_user
    @user = User.find(params[:id])
  end
end