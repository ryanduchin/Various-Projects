class Comment < ActiveRecord::Base
  validates :body, :commentable_type, :commentable_id, :author_id, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: 'User', foreign_key: :author_id
end
