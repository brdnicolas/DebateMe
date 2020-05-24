class PostsController < ApplicationController
  before_action :set_user
  before_action :set_user_post, only: [:show, :update, :destroy]

  # GET /users/:user_id/posts
  def index
    json_response(current_user.posts)
  end

  # GET /users/:user_id/posts/:id
  def show
    json_response(@post)
  end

  # POST /posts
  def create
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end

  # PUT /users/:user_id/posts/:id
  def update
    @post.update(post_params)
    head :no_content
  end

  # DELETE /users/:user_id/posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:content, :isAnonym, :up, :down)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_post
    @post = @user.posts.find_by!(id: params[:id]) if @user
  end
end