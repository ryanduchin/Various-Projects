# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :author_id, :sub_ids, presence: true
  attr_reader :all_comments_hash

  belongs_to :author, class_name: "User", foreign_key: :author_id

  has_many :post_subs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub

  def comments_by_parent_id
    @all_comments_hash = Hash.new{|h,k| h[k] = [] }

    self.comments.each do |comment|
      @all_comments_hash[comment.parent_comment_id] = comment
    end

    @all_comments_hash
  end
end
