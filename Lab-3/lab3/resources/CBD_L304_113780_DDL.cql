-- Drop the keyspace if it exists
DROP KEYSPACE IF EXISTS puzzle_shop;

-- Create the keyspace
CREATE KEYSPACE puzzle_shop WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};
USE puzzle_shop;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS puzzle;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS solved_puzzles;
DROP TABLE IF EXISTS comments_ratings;
DROP TABLE IF EXISTS liked_puzzles;

-- Create table for puzzles
CREATE TABLE puzzle (
    id int PRIMARY KEY,
    subject text,
    piece_number int,
    price float,
    tags set<text>
);

-- Create table for users
CREATE TABLE users (
    username text PRIMARY KEY,
    name text,
    email text
);

-- Create table for solved puzzles with a more normalized approach
CREATE TABLE solved_puzzles (
    username text,
    puzzle_id int,
    date_solved date,
    PRIMARY KEY (username, puzzle_id)
);

-- Create table for comments and ratings with renamed fields for clarity
CREATE TABLE comments_ratings (
    puzzle_id int,
    username text,
    comment text,
    rating int,
    time_of timestamp,
    PRIMARY KEY (puzzle_id, time_of, username)
);

-- Create table for liked puzzles with a more normalized approach
CREATE TABLE liked_puzzles (
    username text,
    puzzle_id int,
    PRIMARY KEY (username, puzzle_id)
);

-- Drop existing indexes if they exist
DROP INDEX IF EXISTS idx_piece_number;
DROP INDEX IF EXISTS idx_tag;
DROP INDEX IF EXISTS idx_rating;

-- Create indexes to improve query performance
CREATE INDEX idx_piece_number ON puzzle(piece_number);
CREATE INDEX idx_tag ON puzzle(tags);
CREATE INDEX idx_rating ON comments_ratings(rating);

-- Create a User Defined Function (UDF) to calculate the total price of puzzles
-- CREATE OR REPLACE FUNCTION puzzle_shop.calculate_total_price(puzzle_prices list<float>)
-- RETURNS NULL ON NULL INPUT
-- RETURNS float
-- LANGUAGE java
-- AS '
--   float total = 0;
--   for (float price : puzzle_prices) {
--     total += price;
--   }
--   return total;
-- ';

-- -- Create a User Defined Aggregate (UDA) to aggregate the total price of solved puzzles
-- CREATE AGGREGATE puzzle_shop.total_price(float)
-- SFUNC calculate_total_price
-- STYPE float
-- INITCOND 0;