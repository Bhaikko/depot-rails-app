class CategoriesController < ApplicationController
  def index
    @categories = Category.root_categories
  end
end
