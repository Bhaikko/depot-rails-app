class LineItem < ApplicationRecord
  # These add navigation capabilities to model objects
  # Using these, product and cart info can be retrieved using line_item
  belongs_to :product
  belongs_to :cart

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      # build method builds a lineitem with relationship between line_item object and product
      current_item = line_items.build(product_id: product.id)
    end

    current_item
  end
end
