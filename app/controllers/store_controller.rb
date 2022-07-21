class StoreController < ApplicationController
  include CurrentCart

  before_action :set_cart

  def index
    # Getting List of Products ordered by title
    @products = Product.order(:title)
  end
end
