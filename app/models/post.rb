class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :title, presence: true

  has_many :comments, dependent: :destroy
  before_validation :restrict_user_modifications, on: [:create, :update]
  before_destroy :restrict_user_deletion

  private 
  def restrict_user_modifications
    if Current.user.role == 'user'
      errors.add(:base, "You are not allowed to create or edit posts.")
      throw(:abort)
    end
  end

  def restrict_user_deletion
    if Current.user.role == 'user'
      errors.add(:base, "You are not allowed to delete posts.")
      throw(:abort)
    end
  end
  
end
