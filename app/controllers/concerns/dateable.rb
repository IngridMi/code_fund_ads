module Dateable
  extend ActiveSupport::Concern

  included do
    before_action :set_dates
  end

  private

  def set_dates
    @start_date = session[:start_date].present? ?
      Date.strptime(session[:start_date], "%m/%d/%Y") :
      Date.current.beginning_of_month

    @end_date = session[:end_date].present? ?
      Date.strptime(session[:end_date], "%m/%d/%Y") :
      Date.current

    if params[:date_range].present?
      dates = params[:date_range].split(" - ")
      @start_date = Date.strptime(dates[0], "%m/%d/%Y")
      @end_date = Date.strptime(dates[1], "%m/%d/%Y")
    end

    session[:start_date] = @start_date.to_s("mm/dd/yyyy")
    session[:end_date] = @end_date.to_s("mm/dd/yyyy")
  end
end
