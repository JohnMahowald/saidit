class Sub < ActiveRecord::Base
  validates :moderator_id, :title, presence: true
  
  belongs_to :moderator, class_name: "User", foreign_key: :moderator_id
  
  has_many :posts
  has_many :post_subs, inverse_of: :sub
  has_many :shared_posts, through: :post_subs, source: :post
  
  def is_moderator?(current_user)
    moderator.id == current_user.id
  end
end