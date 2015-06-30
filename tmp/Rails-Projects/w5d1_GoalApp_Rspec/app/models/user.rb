class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true }
  validates :username, :session_token, uniqueness: true

  attr_reader :password
  before_validation :ensure_session_token
  has_many :goals
  has_many :comments, as: :commentable
  has_many :authored_comments, class_name: 'Comment', foreign_key: :author_id

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(params)
    user = User.find_by(username: params[:username])
    if user && user.is_password?(params[:password])
      return user
    else
      return nil
    end
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    token = SecureRandom::urlsafe_base64(16)
    until !User.find_by(session_token: token)
      token = SecureRandom::urlsafe_base64(16)
    end
    self.session_token = token
    self.save!
    token
  end
end
