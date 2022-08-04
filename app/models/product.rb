class Product < ApplicationRecord
  IMAGE_VALIDATION_REGEX = %r{\.(gif|jpg|png)\z}i.freeze

  has_many :line_items, dependent: :restrict_with_exception

  has_many :orders, through: :line_items

  validates :title, :description, :image_url, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  validates :title, uniqueness: true

  validates :image_url, allow_blank: true, format: {
    with:   IMAGE_VALIDATION_REGEX,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }

  after_initialize do |product|
    product.title = 'abc' if product.title.blank?
  end

  before_save do |product|
    product.discount_price = product.price if product.discount_price.blank?
  end
end
