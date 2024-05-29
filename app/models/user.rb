class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true,uniqueness: true;
    validate :email_format
    enum role: { user: 'user', author: 'author', admin: 'admin' }
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    private

    def email_format
        unless email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        errors.add(:email, "is not a valid email address")
        end
    end
end
