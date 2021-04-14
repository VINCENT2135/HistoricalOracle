class User < ApplicationRecord
        before_save { self.email = email.downcase }
        has_many :articles, dependent: :destroy
        validates :username, presence: true,
                             uniqueness: { case_sensitive: false },
                             length: { minimum: 3, maximum: 25 }
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        validates :email, presence: true,
                            uniqueness: { case_sensitive: false }, 
                            length: { maximum: 105 },
                          format: { with: VALID_EMAIL_REGEX }
        has_secure_password



  def self.from_omniauth(response)

                User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
                        u.username = response[:info][:name]
                        u.email = response [:info][:email]
                        u.password = SecureRandom.hex(15)

                end

        end 
        
end 


