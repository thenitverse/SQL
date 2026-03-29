CREATE TABLE users(id INTEGER PRIMARY KEY,username TEXT NOT NULL UNIQUE);
INSERT INTO users(id,username)
VALUES(1,'Maya');
INSERT INTO users(id,username)
VALUES(2,'Leo');
INSERT INTO users(id,username)
VALUES(3,'Roy');
INSERT INTO users(id,username)
VALUES(4,'Sam');

CREATE TABLE posts(id INTEGER PRIMARY KEY, user_id INTEGER NOT NULL, 
caption TEXT NOT NULL,FOREIGN KEY(user_id) REFERENCES users(id)
);
INSERT INTO posts(id,user_id,caption)
VALUES(1,1,'sunset at the beach');
INSERT INTO posts(id,user_id,caption)
VALUES(2,2,'Homemade pizza night');
INSERT INTO posts(id,user_id,caption)
VALUES(3,3,'morning hike vibes');

CREATE TABLE comments(id INTEGER PRIMARY KEY,post_id INTEGER NOT NULL,user_id INTEGER NOT NULL,body TEXT NOT NULL,
FOREIGN KEY(post_id) REFERENCES posts(id),FOREIGN KEY(user_id) REFERENCES users(id)
);
INSERT INTO comments (id, post_id, user_id, body)
VALUES (1, 1, 2, 'That sky looks unreal');

INSERT INTO comments (id, post_id, user_id, body)
VALUES (2, 1, 3, 'Love the colors');

INSERT INTO comments (id, post_id, user_id, body)
VALUES (3, 1, 2, 'Which beach is this?');

INSERT INTO comments (id, post_id, user_id, body)
VALUES (4, 2, 1, 'Save me a slice');

INSERT INTO comments (id, post_id, user_id, body)
VALUES (5, 2, 4, 'That crust looks perfect');

INSERT INTO comments (id, post_id, user_id, body)
VALUES (6, 2, 1, 'What toppings did you use?');

INSERT INTO comments (id, post_id, user_id, body)
VALUES (7, 3, 4, 'Amazing view');
CREATE TABLE comment_likes (
  user_id INTEGER NOT NULL,
  comment_id INTEGER NOT NULL
);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (1, 1);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (3, 1);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (4, 1);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (1, 2);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (2, 2);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (3, 4);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (4, 4);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (2, 5);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (3, 5);

INSERT INTO comment_likes (user_id, comment_id)
VALUES (1, 7);


SELECT posts.caption AS post_caption, comments.id AS comment_id, users.username AS commenter_username,
 comments.body AS comment_body, COUNT(comment_likes.user_id) AS comment_like_count, comment_totals.total_comments_by_user_on_post
  FROM comments 
JOIN posts ON comments.post_id = posts.id
join users ON comments.user_id = users.id
LEFT JOIN  comment_likes ON comments.id = comment_likes.comment_id
 
JOIN (
  SELECT post_id, user_id, COUNT(*) AS total_comments_by_user_on_post
  FROM comments
  GROUP BY post_id, user_id
) AS comment_totals
  ON comments.post_id = comment_totals.post_id
  AND comments.user_id = comment_totals.user_id

GROUP BY posts.caption, comments.id, users.username, comments.body, comment_totals.total_comments_by_user_on_post
ORDER BY  comments.id ASC;