class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true
  validates :long_url, presence: true, length: { maximum: 1024 }
  validate :submission_time_limit, :premium_length_requirement, :nonpremium_url_cap

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :visits,
    source: :users
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :topics,
    through: :taggings,
    source: :topic
  )

  has_many(
    :votes,
    class_name: 'Voting',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :voting_users,
    through: :votes,
    source: :users
  )


  def self.random_code
    short_url = nil
    loop do
      short_url = SecureRandom::urlsafe_base64(6)[0..5]
      break if !ShortenedUrl.exists?(short_url: short_url)
    end
    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(short_url: random_code, submitter_id: user.id, long_url: long_url)
  end

  def self.create_custom_url!(user, long_url, custom_url)
    short_url = custom_url
    i = 1
    until !ShortenedUrl.exists?(short_url: short_url)
      short_url = custom_url + i.to_s
      i += 1
    end
    create!(short_url: short_url, submitter_id: user.id, long_url: long_url)
  end

  def self.prune
    new_ids = Visit.
      where('created_at > ?', 5.minutes.ago).
      pluck(:shortened_url_id)
    where.not(id: new_ids).destroy_all
  end


  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where("visits.updated_at > ?", 10.minutes.ago)
  end

  private

  def submission_time_limit
    if ShortenedUrl
        .where("created_at > ? AND submitter_id = ?", 1.minute.ago, submitter.id)
        .count >= 5
      errors.add(:submission_speed, "cannot break the speed of light")
    end
  end

  def premium_length_requirement
    premium = User.find(submitter_id).premium
    if premium && short_url.length < 4
      errors.add(:length, "cannot be below 4 characters for premium member")
    elsif !premium && short_url.length < 6
      errors.add(:length, "cannot be below 6 characters for non-premium member")
    end
  end

  def nonpremium_url_cap
    if User
        .joins('JOIN shortened_urls ON shortened_urls.submitter_id = users.id')
        .where('user.id = ? AND premium = false', submitter_id)
        .count > 5
      errors.add(:url_count, "cannot exceed 5 for non-premium users")
    end
  end


end
