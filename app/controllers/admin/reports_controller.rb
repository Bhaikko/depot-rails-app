class Admin::ReportsController < ApplicationController
  before_action :authorize_admin

  def index
    @from = params[:from]
    @to = params[:to]

    if params[:from].present? && params[:to].blank? || params[:from].blank? && params[:to].present?
      flash.now[:notice] = 'Please mention both From and To field'
      render :index and return
    end

    if params[:from].present? && params[:to].present?
      @orders = Order.by_date(params[:from], params[:to])
    else
      @orders = Order.by_date(5.days.ago, Time.now)
    end 
  end
end
