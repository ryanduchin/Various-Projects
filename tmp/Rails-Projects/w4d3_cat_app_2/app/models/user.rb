class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  has_many :cats
  has_many :cat_rental_requests
  has_many :sessions

  # attr_accessor :session_token

  def ensure_session_token
    self.session_token ||= set_session_token
  end

  def set_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
    while User.exists?(session_token: self.session_token)
      self.session_token = SecureRandom::urlsafe_base64(16)
    end
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    set_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(user_name, password)
    # does this user exist, if so, return user, else return nil
    user = User.find_by(user_name: user_name)

    if user && !user.is_password?(password)
      nil
    else
      user
    end
  end

  def logged_in?
    self.sessions.count > 0
  end
end
