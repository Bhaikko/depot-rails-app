class Admin::ReportsController < ApplicationController
  def index
    if params[:from]
      @orders = Order.by_date(params[:from], params[:to])
    else
      @orders = Order.by_date(5.days.ago, Time.now)
    end

  end
end
