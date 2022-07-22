class Product < ApplicationRecord
  IMAGE_VALIDATION_REGEX = %r{\.(gif|jpg|png)\z}i.freeze

  # Adding validation related to Product text field for not being empty
  validates :title, :description, :image_url, presence: true

  # Adding validation related to price being positive number
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # Validation for title being unique
  validates :title, uniqueness: true

  # Validation of url using regex
  validates :image_url, allow_blank: true, format: {
    with:   IMAGE_VALIDATION_REGEX,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }
end
