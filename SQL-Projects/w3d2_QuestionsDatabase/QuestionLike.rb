class QuestionLike

  attr_accessor :id, :liked, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @liked = options['liked']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    results.map { |result| QuestionLike.new(result) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    QuestionLike.new(result.first)
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
    SQL

    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    count = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) as count
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
    SQL

    count.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  #test
  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        question_likes.question_id
      ORDER BY
        COUNT(question_likes.id) DESC
      LIMIT
        ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def create
    raise 'already saved!' unless self.id.nil?
    params = [self.liked, self.user_id, self.question_id]
    QuestionsDatabase.instance.execute(<<-SQL, *params)
      INSERT INTO
        question_likes (liked, user_id, question_id)
      VALUES
        (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end
