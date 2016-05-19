class User < ActiveRecord::Base
    has_secure_password

    validates :password, length: { minimum: 8 } #, allow_nil: true
    validates :email, uniqueness: true

    has_many :public_tokens
    has_many :accounts
    has_many :transactions, through: :accounts

end
