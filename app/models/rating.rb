class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, uniqueness: { scope: :product, message: 'A User can submit only one rating for a product.' }
end
