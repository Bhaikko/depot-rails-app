class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true, counter_cache: true

  validates :product, uniqueness: { 
    scope: :cart,
    message: "has already been taken in Cart."
  }, 
  if: :cart

  def total_price
    product.price * quantity
  end
end
