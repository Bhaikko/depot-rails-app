class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, numericality: { in: 0.0..5.0, message: 'must be between 0.0 and 5.0' }
  validates :user, uniqueness: { scope: :product, message: 'A User can submit only one rating for a product.' }
end
