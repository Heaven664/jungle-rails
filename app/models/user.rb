class User < ApplicationRecord

  has_secure_password

  def self.authenticate_with_credentials(email_address, password)
    email_address.downcase!
    email_address.strip!
    user = User.find_by_email(email_address)
    if user.authenticate(password) 
      return user
    else
      return nil
    end
  end

  before_create do
    self.email = email.downcase
  end


  validates :password, :password_confirmation, :email, :first_name, :last_name, :presence => true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }
end
