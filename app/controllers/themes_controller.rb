class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :update, :destroy]
  skip_before_action :authorize_request


  # GET /themes
  def index
    @themes = Theme.all
    json_response(get_themes_image(@themes))
  end

  # POST /themes
  def create
    @theme = Theme.create!(theme_params) # '!' is here for raise an AR::RecordInvalid exception
    json_response(@theme.get_theme_image, :created)
  end

  # GET /themes/:id
  def show
    json_response(@theme.get_theme_image)
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
    params.permit(:name, :logo)
  end

  def set_theme
    @theme = Theme.find(params[:id])
  end

  def get_themes_image(themes)
    themes.reduce([]) { |memo, theme| memo << theme.get_theme_image }
  end
end