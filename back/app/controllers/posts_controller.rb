class PostsController < ApplicationController

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

  # POST /posts
  def create
    content = post_params[:content]
    validation_content(content)
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

  # GET /posts/:id/vote
  def vote
    @post = Post.find(params[:id])
    vote = UserHasVote.find_vote(current_user.id, @post.id)
    vote.count.zero? ? create_vote : destroy_vote(vote.first)
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
    @post = @user.posts.find_by!(id: params[:id]) if @user || @user.isAdmin
  end

  def create_vote
    UserHasVote.create({ user_id: current_user.id, post_id: @post.id })
    @post.up_vote
    json_response('vote')
  end

  def destroy_vote(vote)
    vote.destroy
    @post.down_vote
    json_response('no vote')
  end

  def validation_content(content)
    # Call Azure API for verify if the post include some forbidden terms
    validation = ValidationContent.get_corrected_text(content)
    if validation.class == Array
      json_response(validation, :partial_content)
    else
      json_response(current_user.posts.create!(post_params), :created)
    end
  end

end