class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  
  after_initialize :ensure_session_token
  
  has_many :subs, foreign_key: :moderator_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  
  def self.find_by_credentials(username, password)
    user = self.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end
  
  private
  
  attr_reader :password
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
end