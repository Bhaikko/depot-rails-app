class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # Adding enum data-type for pay_type column
  enum pay_type: {
    "Check"           => 0,
    "Credit card"     => 1,
    "Purchase order"  => 2
  }

  validates :name, :address, :email, presence: true
  # validating key types as user can still submit form directly from outside 
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      # Setting item cart_id to nil to prevent it from deleted when cart deleted
      item.cart_id = nil
      # pushing line_item to order's line_items
      line_items << item
    end
  end
end
