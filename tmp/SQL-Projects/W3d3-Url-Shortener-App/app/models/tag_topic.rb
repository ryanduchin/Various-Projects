class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )

  has_many(
    :urls,
    through: :taggings,
    source: :url
  )

  def most_popular(n)
    Visit
    .joins('JOIN taggings ON taggings.shortened_url_id = visits.shortened_url_id')
    .joins('JOIN shortened_urls ON shortened_urls.id = taggings.shortened_url_id')
    .where('tag_topic_id = ?', id)
    .group("shortened_url_id")
    .order('COUNT(*) DESC')
    .limit(n)
    .pluck(:long_url)
  end
end
