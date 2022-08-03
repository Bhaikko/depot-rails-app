class Product < ApplicationRecord
  IMAGE_VALIDATION_REGEX = %r{\.(gif|jpg|png)\z}i.freeze
  PERMALINK_REGEX = /\A[a-z0-9-]+\z/i.freeze
  DESCRIPTION_WORDS_REGEX = /[a-z0-9]+/i.freeze

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, :price, :discount_price, presence: true

  validates :price, 
    numericality: { greater_than: 0 },
    allow_blank: true

  validates :discount_price,
    numericality: { greater_than: 0 },
    allow_blank: true
    
  validates :price,
    comparison: { 
      greater_than: :discount_price,
      message: 'must be greater than discount price'
    },
    allow_blank: true

  validates :title, uniqueness: true

  validates :permalink, 
    uniqueness: {
      message: "Should be unique",
      case_sensitive: false
    }, 
    format: {
      with: PERMALINK_REGEX,
      message: "cannot have special character and no space allowed"
    },
    allow_blank: true

  validates_length_of :words_in_description, 
    in: 5..10,
    too_short: 'must be more than 5',
    too_long: 'must be less than 10',
    allow_blank: true

  validates :words_in_permalink_separated_by_hypen,
    comparison: {
      greater_than_or_equal_to: 3
    }

  validates :image_url, 
    image_url: true,
    allow_blank: true

  after_initialize do |product|
    product.title = 'abc' if product.title.blank?
  end

  before_save do |product|
    product.discount_price = product.price if product.discount_price.blank?
  end

  private def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end

  private def words_in_description
    description.scan(DESCRIPTION_WORDS_REGEX)
  end

  private def words_in_permalink_separated_by_hypen
    permalink.split('-').length
  end
end
