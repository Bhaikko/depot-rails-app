class Product < ApplicationRecord
  IMAGE_VALIDATION_REGEX = %r{\.(gif|jpg|png)\z}i.freeze
  NO_SPACE_AND_SPL_CHARACTER_REGEX = /\A[a-z0-9-]+\z/i.freeze
  MIN_3_WORDS_SEP_BY_HYPEN_REGEX = /\w+-\w+-\w+/.freeze
  MATCH_WORD_REGEX = /[a-z0-9]+/i.freeze

  has_many :line_items
  # specifying indirect relationship through another entity
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  # Adding validation related to Product text field for not being empty
  validates :title, :description, :image_url, presence: true

  # Adding validation related to price being positive number
  validates :price, 
    numericality: { 
      greater_than: :discount_price,
      message: "must be greater than Discount price"
    }, 
    unless: -> (x) { x.price.blank? }

  # Validation for title being unique
  validates :title, uniqueness: true

  # Validation of url using regex
  validates :image_url, allow_blank: true, format: {
    with:   IMAGE_VALIDATION_REGEX,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }

  validates :permalink, uniqueness: {
    message: "Should be unique"
  }, format: {
    with: NO_SPACE_AND_SPL_CHARACTER_REGEX,
    message: "cannot have special character and no space allowed"
  } 
  
  validates_each :permalink do |record, attr, value|
    record.errors.add :permalink, "should have minimum 3 words, separated by hyphen" if value.blank? || value.split('-').length < 3
  end

  validates_each :description do |record, attr, value|
    num_of_words = value.scan(MATCH_WORD_REGEX).length
    record.errors.add :description, "should have between 5 and 10 words" if num_of_words < 5 || num_of_words > 10
  end

  validates :image_url, url: true

  ## Creating hook method, executed before rails attempt to destory row in database
  private def ensure_not_referenced_by_any_line_item
    # ensure that there are no line items referencing this product
    unless line_items.empty?
      # same object used by validations to store errors
      errors.add(:base, 'Line Items present')

      # If hook method throws abort then row is not destroyed
      throw :abort
    end
  end
end
