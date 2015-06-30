class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true } #must allow nil if not set

  #before validations
  after_initialize :ensure_session_token


  def self.generate_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    until self.save
      self.session_token = SecureRandom.urlsafe_base64(16)
    end
    self.session_token
  end

  def ensure_session_token
    # self.session_token ||= reset_session_token #NO! stuck in loop
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def password=(password)
    @password = password #need to set password instance variable!!
    self.password_digest = BCrypt::Password.create(password)
  end


  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
    #calls 'is_password' method of BCrypt on hash
  end

  def self.find_by_credentials(params)
    user = User.find_by(email: params[:email])
    (!!user && user.is_password?(params[:password])) ? user : nil
  end


end
