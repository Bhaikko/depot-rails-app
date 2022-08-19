class User < ApplicationRecord
  include ::Exceptions::User

  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders

  validates :name, presence: true, uniqueness: true

  has_secure_password

  before_destroy :ensure_not_admin
  
  after_destroy :ensure_an_admin_remains

  after_create_commit do |user|
    UserMailer.welcome(user).deliver_now
  end

  before_update :ensure_not_admin

  private def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Cant't delete last user"
    end
  end

  private def ensure_not_admin
    raise AdminImmutableException if email_was == 'admin@depot.com'
  end
end
