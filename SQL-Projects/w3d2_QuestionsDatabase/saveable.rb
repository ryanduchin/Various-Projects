module Saveable
  def save(item, db, *kwargs)
    raise 'already saved' unless item.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, db, *kwargs)
      INSERT INTO
        ? ()
      VALUES
        (?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
