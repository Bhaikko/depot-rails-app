class Admin::CategoriesController < AdminController
  def index
    @categories = Category.root_categories
  end
end
