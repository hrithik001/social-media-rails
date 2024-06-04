class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  
  validates :content, presence: true
  validate :validate_person, on: :update
  validate :restrict_user_modifications, on: [ :update, :destroy]


  private
  
  def validate_person
    raise ActiveRecord::AccessDenied, alert: "not allowed" if Current.user.role == 'admin'
  end

  def restrict_user_modifications
    puts "------------------------------------------------------------------------------"
    puts "inside the model verifiction #{Current.user.email}  and the user is #{user}"
    puts "-------------------------------------------------------------------------------"
    if Current.user != user

      errors.add(:base, "from model :: You are not allowed to create or edit posts.")
      throw(:abort)
    end
  end

 
end
