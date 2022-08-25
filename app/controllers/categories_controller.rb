class CategoriesController < ApplicationController
  def index
    @categories = Category.root_categories
  end
  
  def admin_categories
    @categories = Category.all.includes(:parent)
  end
end
