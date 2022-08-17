class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true
  
  has_many :sub_categories, 
    class_name: 'Category',
    foreign_key: 'parent_id',
    dependent: :destroy

  has_many :products, dependent: :restrict_with_error

  has_many :sub_categories_products,
    through: :sub_categories,
    source: :products,
    dependent: :restrict_with_error
    
  validates :name, presence: true

  validates :name, 
    uniqueness: {
      scope: :parent
    },
    unless: -> (category) { category.name.blank? }
    
  validates_each :parent do |record, attr, value|
    current_parent = record.parent
    record.errors.add attr, "can have only one level of nesting" if current_parent && current_parent.parent
  end

  scope :categories_with_subcategories, -> { includes(:sub_categories).where(parent_id: nil) }
end
