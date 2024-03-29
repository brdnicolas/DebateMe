class QuestionsController < ApplicationController
  before_action :set_theme
  skip_before_action :set_theme, only: %i[get_posts]
  before_action :set_theme_question, only: %i[show update destroy]

  # GET /themes/:id/questions
  def index
    json_response(@theme.get_questions_image)
  end

  # POST /themes/:id/questions
  def create
    q_params = question_params
    q_params['start_time'] = DateTime.now.to_date if q_params.nil?
    q_params['end_time'] = q_params['start_time'].to_date + 7.day rescue nil
    @theme.questions.create!(q_params)
    json_response(@theme.get_theme_image, :created)
  end

  # GET /themes/:id/questions/:id
  def show
    json_response(@question.get_question_image)
  end

  # GET /questions/:id/posts
  def get_posts
    set_question
    json_response(@question.posts_parsed)
  end

  # PUT /themes/:id/questions/:id
  def update
    @question.update(question_params)
    head :no_content
  end

  # DELETE /themes/:id/questions/:id
  def destroy
    @question.destroy
    head :no_content
  end

  private

  def question_params
    params.permit(:title, :documentation, :start_time, :end_time, :image)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_theme
    @theme = Theme.find(params[:theme_id])
  end

  def set_theme_question
    @question = @theme&.questions&.find_by!(id: params[:id])
  end
end