class LineItem < ApplicationRecord
  # These add navigation capabilities to model objects
  # Using these, product and cart info can be retrieved using line_item
  belongs_to :product
  belongs_to :cart
end
