class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, :post_subs, presence: true
  
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :sub
  
  has_many :post_subs, inverse_of: :post
  has_many :shared_subs, through: :post_subs, source: :sub
  has_many :comments, dependent: :destroy
  
  def is_author?(user)
    author.id == user.id
  end
end