class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :update, :destroy]
  skip_before_action :authorize_request
  # GET /themes
  def index
    @themes = Theme.all
    json_response(@themes)
  end

  # POST /themes
  def create
    @themes = Theme.create!(theme_params) # '!' is here for raise an AR::RecordInvalid exception
    json_response(@themes, :created)
  end

  # GET /themes/:id
  def show
    json_response({:theme => @theme, :image => @theme.get_image_url})
  end

  # PUT /themes/:id
  def update
    @theme.update(theme_params)
    head :no_content
  end

  # DELETE /themes/:id
  def destroy
    @theme.destroy
    head :no_content
  end

  private

  def theme_params
    # whitelist params
    params.permit(:name, :logo)
  end

  def set_theme
    @theme = Theme.find(params[:id])
  end
end