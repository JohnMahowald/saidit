class Sub < ActiveRecord::Base
  validates :moderator_id, :title, presence: true
  
  belongs_to :moderator, class_name: "User", foreign_key: :moderator_id
  has_many :posts
  
  def is_moderator?(current_user)
    moderator.id == current_user.id
  end
end