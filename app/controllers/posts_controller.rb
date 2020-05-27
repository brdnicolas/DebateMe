class PostsController < ApplicationController
  before_action :set_user, only: [:search_index,:search_show, :search_destroy]
  before_action :set_user_post, only: [:show, :update, :destroy, :search_show, :search_destroy]
  skip_before_action :authorize_request, only: [ :search_show, :search_index ]

  # GET /posts
  def index
    json_response(current_user.posts)
  end

  # GET /users/:user_id/posts
  def search_index
    json_response(@user.posts)
  end

  # GET /posts/:id
  def show
    json_response(@post)
  end

  # GET /users/:user_id/posts/:id
  def search_show
    json_response(@post)
  end

  # POST /posts
  def create
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end

  # PUT /posts/:id
  def update
    @post.update(post_params)
    head :no_content
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  # DELETE /users/:user_id/post/:id
  def search_destroy
    @post.destroy
    head :no_content
  end

  def up_vote
    @post = Post.find(params[:id])
    if UserHasVote.records?(current_user.id, @post.id).count == 0
      UserHasVote.create({user_id: current_user.id, post_id: @post.id })
      @post.up_vote
    end
    head :no_content
  end

  def down_vote
    @post = Post.find(params[:id])
    unless (vote = UserHasVote.records?(current_user.id, @post.id)).nil?
      vote.destroy
      @post.down_vote
    end
    head :no_content
  end

  private

  def post_params
    params.permit(:content, :isAnonym, :up, :down, :subpost_id, :question_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_post
    @user ||= current_user
    @post = @user.posts.find_by!(id: params[:id]) if @user
  end

end