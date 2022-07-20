class Cart < ApplicationRecord
  ## Allows traversing from parent to child in relation
  # dependent declares ON DELETE CASCADE dependency over lineitems for a cart
  has_many :line_items, dependent: :destroy
end
