class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :update, :destroy]
  skip_before_action :authorize_request
  # GET /themes
  def index
    @themes = Theme.all
    new_themes = []
    @themes.each do |theme|
      hash = theme.attributes
      theme.get_image_url if theme.logo.attached?
      new_themes << hash
    end
    json_response(new_themes)
  end

  # POST /themes
  def create
    @themes = Theme.create!(theme_params) # '!' is here for raise an AR::RecordInvalid exception
    json_response(@themes, :created)
  end

  # GET /themes/:id
  def show
    json_response({:theme => @theme, :logo => @theme.get_image_url})
  end

  # PUT /themes/:id
  def update
    @theme.update(theme_params)
    head :no_content
  end

  # DELETE /themes/:id
  def destroy
    @theme.logo.purge if @theme.logo.attached?
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