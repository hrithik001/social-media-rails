class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :title, presence: true

  has_many :comments, dependent: :destroy
  validate :restrict_user_modifications, on: [:create, :update, :destroy]
 

  private 
  def restrict_user_modifications
    if Current.user.role == 'user'
      errors.add(:base, "You are not allowed to create or edit posts.")
      throw(:abort)
    end
  end

 
  
end
