class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  # Validates that the two passwords match in field
  has_secure_password
end
