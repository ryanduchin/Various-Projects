class Session < ActiveRecord::Base
  validates :user_id, :session_token, presence: true
  validates :user_id, uniqueness: true

  belongs_to :user

  #lol what is this class for
end
