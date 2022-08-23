class AdminController < ApplicationController
  before_action :authorize_admin

  def index
    @total_orders = Order.count
  end
end
