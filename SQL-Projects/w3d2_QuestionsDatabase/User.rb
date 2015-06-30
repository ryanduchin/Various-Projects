class User
  attr_accessor :fname, :lname, :id

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map { |result| User.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    User.new(result.first)
  end

  def self.find_by_name(first, last)
    result = QuestionsDatabase.instance.execute(<<-SQL, first, last)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    User.new(result.first)
  end

  def save
    unless self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionFollow.liked_questions_for_user_id(@id)
  end

  # DEF TEST
  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        COUNT(DISTINCT(questions.id)) as total,
        --questions.id, not question_likes.id!
        CAST(COUNT(question_likes.id) as FLOAT) as total_likes
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
         questions.user_id = ?
    SQL

    result.first['total_likes']/result.first['total']
  end

end
