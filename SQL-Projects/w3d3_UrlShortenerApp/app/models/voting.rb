class Voting < ActiveRecord::Base
  validates :user_id, presence: true
  validates :shortened_url_id, presence: true
  validates :vote_value, presence: true, numericality: { greater_than_or_equal_to: -1,
                                                         less_than_or_equal_to: 1 }
  validate :user_cannot_vote_for_own_url, :only_one_vote?

  belongs_to(
    :users,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :shortened_urls,
    class_name: 'ShortenedUrl',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  def only_one_vote?
    if Voting.exists?(user_id: user_id, shortened_url_id: shortened_url_id)
      errors.add(:vote, "cannot be made more than once")
      return false
    end
    true
  end

  private

  def user_cannot_vote_for_own_url
    if Voting.joins('JOIN shortened_urls ON shortened_urls.submitter_id = user_id')
        .where('shortened_urls.submitter_id = ? AND shortened_urls.id = ?', user_id, shortened_url_id)
        .any?
      errors.add(:vote, "cannot be made on a user's own submitted link")
    end
  end
end
