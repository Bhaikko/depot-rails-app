class Product < ApplicationRecord
  IMAGE_VALIDATION_REGEX = %r{\.(gif|jpg|png)\z}i.freeze
  ALPHA_NUMERIC_HYPHEN_REGEX = /\A[a-z0-9-]+\z/i.freeze
  ALPHA_NUMERIC_REGEX = /[a-z0-9]+/i.freeze

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, :price, :discount_price, presence: true

  validates :price, 
    numericality: { greater_than: 0 },
    if: -> (x) { x.price.present? }

  validates :discount_price,
    numericality: { greater_than: 0 },
    if: -> (x) { x.discount_price.present? }
    
  validates :price,
    comparison: { 
      greater_than: :discount_price,
      message: 'must be greater than discount price'
    },
    if: -> (x) { x.discount_price? }

  validates :title, uniqueness: true

  validates :image_url, format: {
    with:   IMAGE_VALIDATION_REGEX,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }

  validates :permalink, uniqueness: {
    message: "Should be unique"
  }, format: {
    with: ALPHA_NUMERIC_HYPHEN_REGEX,
    message: "cannot have special character and no space allowed"
  } 
  
  validates_each :permalink do |record, attr, value|
    record.errors.add :permalink, "should have minimum 3 words, separated by hyphen" if value.blank? || value.split('-').length < 3
  end

  validates_each :description do |record, attr, value|
    num_of_words = value.scan(ALPHA_NUMERIC_REGEX).length
    record.errors.add :description, "should have between 5 and 10 words" if num_of_words < 5 || num_of_words > 10
  end

  validates :image_url, url: true

  private def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
