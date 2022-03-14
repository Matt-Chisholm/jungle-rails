class User < ActiveRecord::Base

  has_secure_password
  validates :password, presence: true
  validates :password, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials email, password
    if email
      user = User.find_by_email(email.strip.downcase)
      if user && user.authenticate(password)
        user
      else
        nil
      end
    else 
      nil
    end
  end

end
