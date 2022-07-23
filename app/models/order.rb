class Order < ApplicationRecord
  # Adding enum data-type for pay_type column
  enum pay_type: {
    "Check"           => 0,
    "Credit card"     => 1,
    "Purchase order"  => 2
  }

  validates :name, :address, :email, presence: true
  # validating key types as user can still submit form directly from outside 
  validates :pay_type, inclusion: pay_type.keys
end
