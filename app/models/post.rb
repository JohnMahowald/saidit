class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true
  
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :sub
  
  def is_author?(user)
    author.id == user.id
  end
end