class User < ApplicationRecord
    # validation's
    has_secure_password
    validates :email, presence: true,uniqueness: true;
    validate :email_format
    enum role: { user: 'user', author: 'author', admin: 'admin' }
    validates :role, presence: true, inclusion: { in: %w[admin author user] }
    validates :password, presence: true, length: { minimum: 6 }

    #associations
    has_many :posts,dependent: :destroy

    private

    def email_format
        unless email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        errors.add(:email, "is not a valid email address")
        end
    end
end
