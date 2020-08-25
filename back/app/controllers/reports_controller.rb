class ReportsController < ApplicationController
  before_action :set_report, only: %i[update destroy show]
  before_action :admin?, except: %i[create update get_reasons]
  skip_before_action :admin?

  # GET /reports
  def index
    @reports = Report.all
    json_response(@reports)
  end

  # GET /reports_reasons
  def get_reasons
    @reasons = ReasonReport.all
    json_response(@reasons)
  end

  # GET /reports_sort
  def get_sorted_reports
    @reports = Report.all.where('processed = false').order('post_id, reason_report_id')
    json_response(@reports)
  end

  # POST /reports
  def create
    params = report_params.merge({ user_id: current_user.id })
    report = Report.create!(params)
    json_response(report, :created)
  end

  # GET /reports/:id
  def show
    json_response(@report)
  end

  # PUT /reports/:id
  def update
    if (@report.user == current_user) || current_user.isAdmin
      @report.update(report_params)
      head :no_content
    else
      head :forbidden
    end
  end

  # DELETE /reports/:id
  def destroy
    @report.destroy
    head :no_content
  end

  private

  def report_params
    params.permit(:reason_report_id, :message, :post_id)
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def admin?
    head :forbidden unless current_user.isAdmin
  end
end
