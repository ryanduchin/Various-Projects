class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many(
    :submitted_urls,
    class_name: 'ShortenedUrl',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :visitor_id,
    primary_key: :id
  )

  has_many(
    :visited_urls,
    -> { distinct },
    through: :visits,
    source: :shortened_urls
  )

  has_many(
    :votes,
    class_name: 'Voting',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :voted_urls,
    through: :votes,
    source: :shortened_urls
  )

  def upvote(url)
    vote = Voting.new(user_id: id, shortened_url_id: url.id, vote_value: 1)
    if !vote.only_one_vote?
      vote.update_attribute('vote_value', 1)
    else
      vote.save!
    end
  end

  def downvote(url)
    vote = Voting.new(user_id: id, shortened_url_id: url.id, vote_value: -1)
    if !vote.only_one_vote?
      vote.update_attribute('vote_value', -1)
    else
      vote.save!
    end
  end
end
