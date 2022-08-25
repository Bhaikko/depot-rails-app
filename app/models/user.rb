class User < ApplicationRecord
  include Exceptions::User
  
  validates :name, :email, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: {
    with: EMAIL_REGEX
  }

  has_secure_password

  before_destroy :ensure_not_admin
  
  after_destroy :ensure_an_admin_remains

  after_create_commit :send_mail_to_new_user

  before_update :ensure_not_admin

  private def ensure_an_admin_remains
    if User.count.zero?
      raise Error.new "Cant't delete last user"
    end
  end

  private def ensure_not_admin
    raise AdminImmutableException if email_was == 'admin@depot.com'
  end

  private def send_mail_to_new_user
    UserMailer.welcome(self).deliver_now
  end
end
