# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :subs, foreign_key: :moderator_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  attr_reader :password

  def self.find_by_credentials(params)
    user = User.find_by(username: params[:username])
    user && user.is_password?(params[:password]) ? user : nil
  end

  def self.create_session_token
    token = SecureRandom.urlsafe_base64(16)
    until User.find_by(session_token: token).nil?
      token = SecureRandom.urlsafe_base64(16)
    end
    token
  end

  def ensure_session_token
    self.session_token ||= User.create_session_token
  end

  def reset_session_token
    self.session_token = User.create_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    return if password.nil?
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
