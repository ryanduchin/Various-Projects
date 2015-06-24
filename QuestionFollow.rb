class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM questions_follows')
    results.map { |result| QuestionFollow.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions_follows
      WHERE
        id = ?
    SQL

    QuestionFollow.new(result.first)
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        questions_follows ON questions_follows.user_id = users.id
      WHERE
        questions_follows.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        questions_follows ON questions_follows.question_id = questions.id
      WHERE
        questions_follows.user_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        questions_follows ON questions_follows.question_id = questions.id
      GROUP BY
        questions_follows.question_id
      ORDER BY
        COUNT(questions_follows.user_id) DESC
      LIMIT
        ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def create
    raise 'already saved!' unless self.id.nil?
    params = [self.user_id, self.question_id]
    QuestionsDatabase.instance.execute(<<-SQL, *params)
      INSERT INTO
        questions (user_id, question_id)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

end
