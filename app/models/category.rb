class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true

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
end
