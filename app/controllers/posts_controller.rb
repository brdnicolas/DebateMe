class PostsController < ApplicationController
  before_action :set_user, only: [:search_index,:search_show, :search_destroy]
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
    json_response(Post.find(params[:id]))
  end

  # GET /users/:user_id/posts/:id
  def search_show
    json_response(@post)
  end

  # POST /posts
  def create
    content = post_params[:content]
    validation = validation_content(content)
    puts "#{validation.class}"
    if validation.class == Array
      json_response(validation, :unprocessable_entity)
    else
      @post = current_user.posts.create!(post_params)
      json_response(@post, :created)
    end
  end

  # PUT /posts/:id
  def update
    Post.find(params[:id]).update(post_params)
    head :no_content
  end

  # DELETE /posts/:id
  def destroy
    @post = Post.find(params[:id]).destroy
    head :no_content
  end

  # DELETE /users/:user_id/post/:id
  def search_destroy
    @post.destroy
    head :no_content
  end

  # GET /vote
  def vote
    @post = Post.find(params[:id])
    vote = UserHasVote.records(current_user.id, @post.id)
    vote.count == 0 ? create_vote : destroy_vote(vote.first)
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
    @post = @user.posts.find_by!(id: params[:id]) if @user or @user.isAdmin
  end

  def create_vote
    UserHasVote.create({user_id: current_user.id, post_id: @post.id })
    @post.up_vote
    json_response('vote')
  end

  def destroy_vote(vote)
    vote.destroy
    @post.down_vote
    json_response('no vote')
  end

  def validation_content(content)
    ValidationContent.new(content).get_corrected_text
  end

end