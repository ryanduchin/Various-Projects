DROP TABLE users;
DROP TABLE questions;
DROP TABLE questions_follows;
DROP TABLE replies;
DROP TABLE question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY autoincrement,
  fname STRING NOT NULL,
  lname STRING NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER NOT NULL references users(id)
);

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL references users(id),
  question_id INTEGER NOT NULL references questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  question_id INTEGER NOT NULL references questions(id),
  parent_id INTEGER NULL references replies(id),
  user_id INTEGER NOT NULL references users(id),
  body VARCHAR(255) NULL
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  liked INTEGER DEFAULT 0,
  user_id INTEGER NOT NULL references user(id),
  question_id INTEGER NOT NULL references questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('ryan', 'duchin');

INSERT INTO
  users (fname, lname)
VALUES
  ('char', 'lee');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Question1', 'This is Q1.', (SELECT id FROM users WHERE fname = 'ryan' AND lname = 'duchin'));

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Question2', 'This is Q2.', (SELECT id FROM users WHERE fname = 'char'));

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Question3', 'This is Q3.', (SELECT id FROM users WHERE fname = 'ryan' AND lname = 'duchin'));

INSERT INTO
  questions_follows(user_id, question_id)
VALUES
  (1, 1), (1,2), (2,2);

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 1, "reply1"), (1, 1, 2, "reply2 to reply1"), (2, NULL, 2,"1st reply to q2");


INSERT INTO
  question_likes(liked, user_id, question_id)
VALUES
  (1,1,1), (1,2,2);
