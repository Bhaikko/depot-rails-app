class StoreController < ApplicationController
  def index
    # Getting List of Products ordered by title
    @products = Product.order(:title)
  end
end
