class Order < ApplicationRecord
  # Adding enum data-type for pay_type column
  enum pay_type: {
    "Check"           => 0,
    "Credit card"     => 1,
    "Purchase order"  => 2
  }
end
