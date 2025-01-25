-- Use Keyspace
USE video_share_db;

-- Seed Data for Users
INSERT INTO users (username, name, email, registration_timestamp)
VALUES ('john_doe', 'John Doe', 'john.doe@example.com', '2020-01-01T08:30:00Z');
INSERT INTO users (username, name, email, registration_timestamp)
VALUES ('jane_smith', 'Jane Smith', 'jane.smith@example.com', '2020-02-15T10:45:00Z');
INSERT INTO users (username, name, email, registration_timestamp)
VALUES ('alice_jones', 'Alice Jones', 'alice.jones@example.com', '2020-03-10T12:15:00Z');
INSERT INTO users (username, name, email, registration_timestamp)
VALUES ('bob_martin', 'Bob Martin', 'bob.martin@example.com', '2020-04-20T14:00:00Z');
INSERT INTO users (username, name, email, registration_timestamp)
VALUES ('charlie_lee', 'Charlie Lee', 'charlie.lee@example.com', '2020-05-05T16:30:00Z');

-- Seed Data for Videos
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (1, 'john_doe', 'Travel Vlog: Paris', 'Exploring the beautiful city of Paris', {'travel', 'vlog', 'Paris', 'Aveiro'}, '2020-01-10T10:00:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (1, 'john_doe', 'Travel Vlog: Paris', 'Best spots in Paris', {'travel', 'tourist', 'France'}, '2020-01-11T15:00:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (1, 'john_doe', 'Travel Vlog: Paris', 'Food in Paris', {'food', 'travel', 'Paris'}, '2020-01-12T18:00:00Z');

INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (2, 'jane_smith', 'DIY: Home Decor Ideas', 'Creative ways to decorate your home', {'DIY', 'home', 'decor'}, '2020-02-20T12:30:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (2, 'jane_smith', 'DIY: Home Decor Ideas', 'Budget-friendly DIYs', {'DIY', 'budget', 'decor'}, '2020-02-21T13:30:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (2, 'jane_smith', 'DIY: Home Decor Ideas', 'Wall decorations', {'DIY', 'art', 'home'}, '2020-02-22T15:30:00Z');

INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (3, 'alice_jones', 'Cooking with Alice: Pasta', 'Delicious pasta recipes for beginners', {'cooking', 'recipes', 'pasta'}, '2020-03-25T14:45:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (3, 'alice_jones', 'Cooking with Alice: Desserts', 'Simple dessert recipes that anyone can make', {'cooking', 'desserts', 'recipes'}, '2020-03-26T14:45:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (3, 'alice_jones', 'Cooking with Alice: Breakfast', 'Healthy and quick breakfast ideas', {'cooking', 'breakfast', 'healthy'}, '2020-03-27T14:45:00Z');

INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (4, 'bob_martin', 'Tech Review: Laptops', 'Reviewing the latest laptops of 2020', {'tech', 'gadgets', 'laptops'}, '2020-04-15T16:15:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (4, 'bob_martin', 'Tech Review: Smartphones', 'Detailed reviews of the top smartphones', {'tech', 'gadgets', 'smartphones','Aveiro'}, '2020-04-16T16:15:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp)
VALUES (4, 'bob_martin', 'Tech Review: Tablets', 'Comparing the latest tablets of 2020', {'tech', 'gadgets', 'tablets'}, '2020-04-17T16:15:00Z');

-- Seed Data for Comments
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (1, 1, 'jane_smith', 'Amazing vlog! Makes me want to visit Paris.', '2020-01-11T08:00:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (2, 1, 'bob_martin', 'Great visuals and narration!', '2020-01-12T09:30:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (3, 1, 'alice_jones', 'I loved the food segment!', '2020-01-13T10:30:00Z');

INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (4, 2, 'john_doe', 'Loved these decor ideas. Very creative!', '2020-02-21T10:45:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (5, 2, 'charlie_lee', 'Helpful tips for small spaces!', '2020-02-22T11:15:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (6, 2, 'bob_martin', 'Budget-friendly ideas are amazing!', '2020-02-23T12:00:00Z');

INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (7, 3, 'john_doe', 'The pasta recipe was fantastic! My family loved it.', '2020-03-26T10:00:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (8, 3, 'charlie_lee', 'I made the dessert, and it turned out amazing!', '2020-03-27T11:00:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (9, 3, 'jane_smith', 'Breakfast recipes are a lifesaver. Thanks!', '2020-03-28T12:00:00Z');

INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (10, 4, 'alice_jones', 'Great laptop reviews. Helped me pick the best one!', '2020-04-16T10:00:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (11, 4, 'jane_smith', 'The smartphone comparison was very detailed.', '2020-04-17T11:00:00Z');
INSERT INTO comments (comment_id, video_id, author, content, timestamp)
VALUES (12, 4, 'charlie_lee', 'Thanks for the tablet review. Just bought one!', '2020-04-18T12:00:00Z');

-- Seed Data for Comments by Video
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (1, 1, 'jane_smith', 'Amazing vlog! Makes me want to visit Paris.', '2020-01-11T08:00:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (2, 1, 'bob_martin', 'Great visuals and narration!', '2020-01-12T09:30:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (3, 1, 'alice_jones', 'I loved the food segment!', '2020-01-13T10:30:00Z');

INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (4, 2, 'john_doe', 'Loved these decor ideas. Very creative!', '2020-02-21T10:45:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (5, 2, 'charlie_lee', 'Helpful tips for small spaces!', '2020-02-22T11:15:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (6, 2, 'bob_martin', 'Budget-friendly ideas are amazing!', '2020-02-23T12:00:00Z');

INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (7, 3, 'john_doe', 'The pasta recipe was fantastic! My family loved it.', '2020-03-26T10:00:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (8, 3, 'charlie_lee', 'I made the dessert, and it turned out amazing!', '2020-03-27T11:00:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (9, 3, 'jane_smith', 'Breakfast recipes are a lifesaver. Thanks!', '2020-03-28T12:00:00Z');

INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (10, 4, 'alice_jones', 'Great laptop reviews. Helped me pick the best one!', '2020-04-16T10:00:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (11, 4, 'jane_smith', 'The smartphone comparison was very detailed.', '2020-04-17T11:00:00Z');
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp)
VALUES (12, 4, 'charlie_lee', 'Thanks for the tablet review. Just bought one!', '2020-04-18T12:00:00Z');

-- Seed Data for Video Ratings
INSERT INTO video_ratings (video_id, rating)
VALUES (1, 5);
INSERT INTO video_ratings (video_id, rating)
VALUES (1, 4);
INSERT INTO video_ratings (video_id, rating)
VALUES (1, 3);

INSERT INTO video_ratings (video_id, rating)
VALUES (2, 5);
INSERT INTO video_ratings (video_id, rating)
VALUES (2, 4);
INSERT INTO video_ratings (video_id, rating)
VALUES (2, 4);

INSERT INTO video_ratings (video_id, rating)
VALUES (3, 5);
INSERT INTO video_ratings (video_id, rating)
VALUES (3, 4);
INSERT INTO video_ratings (video_id, rating)
VALUES (3, 3);

INSERT INTO video_ratings (video_id, rating)
VALUES (4, 5);
INSERT INTO video_ratings (video_id, rating)
VALUES (4, 5);
INSERT INTO video_ratings (video_id, rating)
VALUES (4, 4);

-- Seed Data for Video Followers
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (1, 'jane_smith', '2020-01-10T11:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (1, 'bob_martin', '2020-01-11T12:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (1, 'charlie_lee', '2020-01-12T13:00:00Z');

INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (2, 'john_doe', '2020-02-20T13:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (2, 'alice_jones', '2020-02-21T14:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (2, 'charlie_lee', '2020-02-22T15:00:00Z');

INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (3, 'jane_smith', '2020-03-26T11:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (3, 'charlie_lee', '2020-03-27T12:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (3, 'john_doe', '2020-03-28T13:00:00Z');

INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (4, 'alice_jones', '2020-04-16T11:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (4, 'jane_smith', '2020-04-17T12:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp)
VALUES (4, 'charlie_lee', '2020-04-18T13:00:00Z');

-- Seed Data for Events
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (1, 1, 1, 'play', '2020-01-10T10:01:00Z', 0);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (2, 1, 1, 'pause', '2020-01-10T10:02:00Z', 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (3, 1, 1, 'play', '2020-01-10T10:03:00Z', 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (4, 1, 1, 'pause', '2020-01-10T10:04:00Z', 120);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (5, 1, 1, 'play', '2020-01-10T10:05:00Z', 120);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (6, 1, 1, 'stop', '2020-01-10T10:06:00Z', 180);

INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (7, 2, 1, 'play', '2020-02-20T12:31:00Z', 0);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (8, 2, 1, 'pause', '2020-02-20T12:32:00Z', 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (9, 2, 1, 'play', '2020-02-20T12:33:00Z', 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (10, 2, 1, 'pause', '2020-02-20T12:34:00Z', 120);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (11, 2, 1, 'play', '2020-02-20T12:35:00Z', 120);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (12, 2, 1, 'stop', '2020-02-20T12:36:00Z', 180);

INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (13, 3, 2, 'play', '2020-03-25T14:46:00Z', 0);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (14, 3, 2, 'pause', '2020-03-25T14:47:00Z', 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (15, 3, 2, 'play', '2020-03-25T14:48:00Z', 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (16, 3, 2, 'pause', '2020-03-25T14:49:00Z', 120);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (17, 3, 2, 'play', '2020-03-25T14:50:00Z', 120);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time)
VALUES (18, 3, 2, 'stop', '2020-03-25T14:51:00Z', 180);

-- Seed Data for Events by User
INSERT INTO events_by_user (user_id, event_id, video_id, event_type, event_timestamp, video_time)
VALUES (1, 1, 1, 'play', '2020-01-10T10:01:00Z', 0);
INSERT INTO events_by_user (user_id, event_id, video_id, event_type, event_timestamp, video_time)
VALUES (1, 2, 1, 'pause', '2020-01-10T10:02:00Z', 60);
INSERT INTO events_by_user (user_id, event_id, video_id, event_type, event_timestamp, video_time)
VALUES (1, 3, 1, 'play', '2020-01-10T10:03:00Z', 60);
INSERT INTO events_by_user (user_id, event_id, video_id, event_type, event_timestamp, video_time)
VALUES (1, 4, 1, 'pause', '2020-01-10T10:04:00Z', 120);
INSERT INTO events_by_user (user_id, event_id, video_id, event_type, event_timestamp, video_time)
VALUES (1, 5, 1, 'play', '2020-01-10T10:05:00Z', 120);
INSERT INTO events_by_user (user_id, event_id, video_id, event_type, event_timestamp, video_time)
VALUES (1, 6, 1, 'stop', '2020-01-10T10:06:00Z', 180);

-- Seed Data for Pause Events by User
INSERT INTO pause_events_by_user (user_id, event_id, video_id, event_timestamp, video_time)
VALUES (1, 2, 1, '2020-01-10T10:02:00Z', 60);
INSERT INTO pause_events_by_user (user_id, event_id, video_id, event_timestamp, video_time)
VALUES (1, 4, 1, '2020-01-10T10:04:00Z', 120);

-- Seed Data for Videos by Author
INSERT INTO videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 1, 'Travel Vlog: Paris', 'Exploring the beautiful city of Paris', {'travel', 'vlog', 'Paris'}, '2020-01-10T10:00:00Z');
INSERT INTO videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 2, 'Travel Vlog: Paris - Best spots', 'Best spots in Paris', {'travel', 'tourist', 'France'}, '2020-01-11T15:00:00Z');
INSERT INTO videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 3, 'Travel Vlog: Paris - Food', 'Food in Paris', {'food', 'travel', 'Paris'}, '2020-01-12T18:00:00Z');
INSERT INTO videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 4, 'Travel Vlog: London', 'Exploring the beautiful city of London', {'travel', 'vlog', 'London'}, '2020-02-10T10:00:00Z');
INSERT INTO videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 5, 'Travel Vlog: London - Best spots', 'Best spots in London', {'travel', 'tourist', 'UK'}, '2020-02-11T15:00:00Z');

-- Seed Data for Video Views by User
INSERT INTO video_views_by_user (user_id, video_id, view_count)
VALUES (1, 1, 10);
INSERT INTO video_views_by_user (user_id, video_id, view_count)
VALUES (1, 2, 15);
INSERT INTO video_views_by_user (user_id, video_id, view_count)
VALUES (1, 3, 5);

-- Seed Data for Video Comment Count
INSERT INTO video_comment_count (video_id, comment_count)
VALUES (1, 20);
INSERT INTO video_comment_count (video_id, comment_count)
VALUES (2, 30);
INSERT INTO video_comment_count (video_id, comment_count)
VALUES (3, 25);

-- Seed Data for Recent Videos by Author
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 1, 'Travel Vlog: Paris', 'Exploring the beautiful city of Paris', {'travel', 'vlog', 'Paris'}, '2020-01-10T10:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 2, 'Travel Vlog: Paris - Best spots', 'Best spots in Paris', {'travel', 'tourist', 'France'}, '2020-01-11T15:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 3, 'Travel Vlog: Paris - Food', 'Food in Paris', {'food', 'travel', 'Paris'}, '2020-01-12T18:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 4, 'Travel Vlog: London', 'Exploring the beautiful city of London', {'travel', 'vlog', 'London'}, '2020-02-10T10:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 5, 'Travel Vlog: London - Best spots', 'Best spots in London', {'travel', 'tourist', 'UK'}, '2020-02-11T15:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 6, 'Travel Vlog: London - Food', 'Food in London', {'food', 'travel', 'London'}, '2020-02-12T18:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 7, 'Travel Vlog: Rome', 'Exploring the beautiful city of Rome', {'travel', 'vlog', 'Rome'}, '2020-03-10T10:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 8, 'Travel Vlog: Rome - Best spots', 'Best spots in Rome', {'travel', 'tourist', 'Italy'}, '2020-03-11T15:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 9, 'Travel Vlog: Rome - Food', 'Food in Rome', {'food', 'travel', 'Rome'}, '2020-03-12T18:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 10, 'Travel Vlog: Berlin', 'Exploring the beautiful city of Berlin', {'travel', 'vlog', 'Berlin'}, '2020-04-10T10:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 11, 'Travel Vlog: Berlin - Best spots', 'Best spots in Berlin', {'travel', 'tourist', 'Germany'}, '2020-04-11T15:00:00Z');
INSERT INTO recent_videos_by_author (author, video_id, name, description, tags, upload_timestamp)
VALUES ('john_doe', 12, 'Travel Vlog: Berlin - Food', 'Food in Berlin', {'food', 'travel', 'Berlin'}, '2020-04-12T18:00:00Z');

SELECT JSON * FROM users;

SELECT JSON * FROM videos;

SELECT JSON * FROM comments;

SELECT JSON * FROM comments_by_video;

SELECT JSON * FROM video_ratings;

SELECT JSON * FROM video_followers;

SELECT JSON * FROM events;

SELECT JSON * FROM events_by_user;

SELECT JSON * FROM pause_events_by_user;

SELECT JSON * FROM videos_by_author;

SELECT JSON * FROM video_views_by_user;

SELECT JSON * FROM video_comment_count;

SELECT JSON * FROM recent_videos_by_author;
