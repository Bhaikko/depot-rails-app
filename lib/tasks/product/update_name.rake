namespace :product do
  desc 'Assigns first category to all products without Category'
  task :port_legacy_products => [ :environment ] do 
    category = Category.first
    Product.where(category: nil).update!(category: category) if category
  end
end