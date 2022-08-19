class User < ApplicationRecord
  include Exceptions::User
  
  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders
  has_secure_password

  validates :name, :email, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: {
    with: EMAIL_REGEX
  }

  before_destroy :ensure_not_admin
  after_destroy :ensure_an_admin_remains
  after_create_commit :send_welcome_mail
  before_update :ensure_not_admin

  def admin?
    email == ADMIN_EMAIL
  end

  private def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Cant't delete last user"
    end
  end

  private def ensure_not_admin
    if admin?
      errors.add(:base, 'Cannot update admin account')
      throw :abort
    end
  end

  private def send_welcome_mail
    UserMailer.welcome(self).deliver_now
  end
end
