class Goal < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true
  belongs_to :user
  has_many :comments, as: :commentable
end
