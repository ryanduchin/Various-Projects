class Post < ActiveRecord::Base
  validates :body, :title, length: {minimum: 1}
end
