DROP KEYSPACE IF EXISTS video_share_db;
CREATE KEYSPACE IF NOT EXISTS video_share_db WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Use Keyspace
USE video_share_db;

-- Table for Users
CREATE TABLE users (
   username text PRIMARY KEY,
   name text,
   email text,
   registration_timestamp timestamp
);

-- Table for Videos
CREATE TABLE videos (
     video_id int,
     author text,
     name text,
     description text,
     tags set<text>,
     upload_timestamp timestamp,
     PRIMARY KEY (video_id, upload_timestamp)
) WITH CLUSTERING ORDER BY (upload_timestamp DESC);

CREATE INDEX ON videos (tags);
CREATE INDEX ON videos (author);

-- Table for Videos by Author
CREATE TABLE videos_by_author (
      author text,
      video_id int,
      name text,
      description text,
      tags set<text>,
      upload_timestamp timestamp,
      PRIMARY KEY (author, upload_timestamp)
);

-- Table for Comments
CREATE TABLE comments (
     comment_id int,
     video_id int,
     author text,
     content text,
     timestamp timestamp,
     PRIMARY KEY (video_id, comment_id)
);

-- Table for Comments by User
CREATE TABLE comments_by_user (
        comment_id int,
        video_id int,
        author text,
        content text,
        timestamp timestamp,
        PRIMARY KEY (author, timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);

-- Table for Comments by Video
CREATE TABLE comments_by_video (
        comment_id int,
        video_id int,
        author text,
        content text,
        timestamp timestamp,
        PRIMARY KEY (video_id, timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC);

-- Table for Video Followers
CREATE TABLE video_followers (
     video_id int,
     follower text,
     follow_timestamp timestamp,
     PRIMARY KEY (video_id, follower)
);

-- Table for Events
CREATE TABLE events (
    event_id int,
    video_id int,
    user_id int,
    event_type text,
    event_timestamp timestamp,
    video_time int,
    PRIMARY KEY ((video_id, user_id), event_timestamp)
) WITH CLUSTERING ORDER BY (event_timestamp DESC);

-- Table for Events by User for 4b
CREATE TABLE events_by_user (
    user_id int,
    event_id int,
    video_id int,
    event_type text,
    event_timestamp timestamp,
    video_time int,
    PRIMARY KEY (user_id, event_timestamp)
) WITH CLUSTERING ORDER BY (event_timestamp DESC);

-- Table for Pause Events by User for 4c
CREATE TABLE pause_events_by_user (
    user_id int,
    event_id int,
    video_id int,
    event_timestamp timestamp,
    video_time int,
    PRIMARY KEY (user_id, event_timestamp)
) WITH CLUSTERING ORDER BY (event_timestamp DESC);

-- Table for Video Ratings
CREATE TABLE video_ratings (
    video_id int,
    rating int,
    PRIMARY KEY (video_id, rating)
) WITH CLUSTERING ORDER BY (rating DESC);

-- Table for Video Views by User - 12
CREATE TABLE video_views_by_user (
    user_id int,
    video_id int,
    view_count int,
    PRIMARY KEY (user_id, video_id)
) WITH CLUSTERING ORDER BY (video_id DESC);

-- Table for Video Comment Count - 13
CREATE TABLE video_comment_count (
    video_id int,
    comment_count int,
    PRIMARY KEY (video_id)
);

-- Table for Recent Videos by Author - 14
CREATE TABLE recent_videos_by_author (
    author text,
    video_id int,
    name text,
    description text,
    tags set<text>,
    upload_timestamp timestamp,
    PRIMARY KEY (author, upload_timestamp)
) WITH CLUSTERING ORDER BY (upload_timestamp DESC);