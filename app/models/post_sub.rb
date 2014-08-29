class PostSub < ActiveRecord::Base
  validates :post_id, :sub_id, presence: :true
  validates :post_id, uniqueness: { scope: :sub_id }
  # validates :sub_id, uniqueness: { scope: :post_id }
  
  belongs_to :post
  belongs_to :sub
end