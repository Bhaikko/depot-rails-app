class CategoriesController < ApplicationController
  def index
    @categories = Category.categories_with_subcategories
  end
end
