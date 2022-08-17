class CategoriesController < ApplicationController
  skip_before_action :authorize

  def index
    @categories = Category.categories_with_subcategories
  end
end