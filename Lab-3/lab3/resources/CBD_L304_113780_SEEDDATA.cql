USE puzzle_shop;

-- Insert sample data for puzzles
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (1, 'The Starry Night', 1000, 70, {'Van Gogh', 'art', 'painting'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (2, 'New York', 250, 20, {'city', 'USA'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (3, 'Harry Potter', 1000, 40, {'Harry Potter', 'movies', 'fantasy'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (4, 'Mountain view', 500, 30, {'mountains', 'nature', 'view'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (5, 'The Hudson River', 350, 20, {'river', 'nature', 'view'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (6, 'Office', 1500, 60, {'office', 'work', 'people'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (7, 'Star Wars', 1000, 40, {'Star Wars', 'movies', 'fantasy'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (8, 'Christmas', 500, 30, {'Christmas', 'holidays', 'people'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (9, 'Beach', 1000, 30, {'beach', 'nature', 'view'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (10, 'Harvard University', 750, 30, {'university', 'USA', 'people'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (11, 'Portugal', 1000, 35, {'Portugal', 'culture', 'countries'});
INSERT INTO puzzle(id, subject, piece_number, price, tags) VALUES (12, 'Aveiro', 750, 25, {'Aveiro', 'culture', 'city', 'Portugal'});

-- Insert sample data for users
INSERT INTO users (username, name, email) VALUES ('joao_silva', 'João', 'joao.silva@example.com');
INSERT INTO users (username, name, email) VALUES ('maria_oliveira', 'Maria', 'maria.oliveira@example.com');
INSERT INTO users (username, name, email) VALUES ('antonio_sousa', 'António', 'antonio.sousa@example.com');
INSERT INTO users (username, name, email) VALUES ('catarina_ferreira', 'Catarina', 'catarina.ferreira@example.com');
INSERT INTO users (username, name, email) VALUES ('ana_costa', 'Ana', 'ana.costa@example.com');
INSERT INTO users (username, name, email) VALUES ('miguel_monteiro', 'Miguel', 'miguel.monteiro@example.com');
INSERT INTO users (username, name, email) VALUES ('sofia_ribeiro', 'Sofia', 'sofia.ribeiro@example.com');
INSERT INTO users (username, name, email) VALUES ('rui_pereira', 'Rui', 'rui.pereira@example.com');
INSERT INTO users (username, name, email) VALUES ('helena_martins', 'Helena', 'helena.martins@example.com');
INSERT INTO users (username, name, email) VALUES ('joana_almeida', 'Joana', 'joana.almeida@example.com');
INSERT INTO users (username, name, email) VALUES ('hugo_rocha', 'Hugo', 'hugo.rocha@example.com');
INSERT INTO users (username, name, email) VALUES ('andre_fonseca', 'André', 'andre.fonseca@example.com');
INSERT INTO users (username, name, email) VALUES ('joao_carlos', 'João', 'joao.carlos@example.com');

-- Insert sample data for solved puzzles
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('joao_silva', 3, '2020-01-01');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('joao_silva', 6, '2021-05-02');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('joao_silva', 8, '2022-12-03');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('joao_silva', 12, '2023-01-04');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('maria_oliveira', 3, '2020-01-01');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('maria_oliveira', 6, '2021-05-02');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('maria_oliveira', 8, '2022-12-03');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('ana_costa', 3, '2021-01-01');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('ana_costa', 7, '2021-06-30');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('ana_costa', 10, '2023-08-24');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('ana_costa', 12, '2023-01-04');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('antonio_sousa', 4, '2020-11-09');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('antonio_sousa', 8, '2023-01-02');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('antonio_sousa', 9, '2022-09-03');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 8, '2023-12-24');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 11, '2018-06-07');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('miguel_monteiro', 4, '2010-08-03');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('sofia_ribeiro', 1, '2023-09-13');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('sofia_ribeiro', 8, '2022-12-03');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('rui_pereira', 10, '2020-01-01');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('helena_martins', 6, '2022-07-02');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('helena_martins', 10, '2023-02-14');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('joana_almeida', 2, '2011-11-11');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('joana_almeida', 5, '2021-04-12');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('hugo_rocha', 12, '2014-12-21');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('andre_fonseca', 3, '2013-05-01');
INSERT INTO solved_puzzles(username, puzzle_id, date_solved) VALUES ('joao_carlos', 1, '2023-09-13');

-- Insert sample data for comments and ratings
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('joao_silva', 3, 'Adorei! está até hoje na minha mesa da sala', 5, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('joao_silva', 8, 'Muito fofoooo, mas gosto de puzzles com mais peças', 4, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('maria_oliveira', 6, 'muito aesthetic e com muitas peças amei', 5, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('antonio_sousa', 9, 'praia linda mas muito difícil', 4, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('catarina_ferreira', 11, 'muito giro mas não tenho paciência para isto', 3, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('ana_costa', 7, 'adoro star wars e este puzzle é muito giro', 5, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('miguel_monteiro', 4, 'muito giro e fácil', 5, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('sofia_ribeiro', 1, 'muito lindooooo', 5, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('rui_pereira', 10, 'muito giro', 4, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('helena_martins', 6, 'muito giro mas muito trabalhoso', 4, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('joana_almeida', 5, 'não é muito giro ao vivo', 3, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('hugo_rocha', 12, 'muito giro e fácil como eu gosto', 5, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('andre_fonseca', 3, 'bué fácil fiz em 1 dia', 5, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('joao_silva', 6, 'gostei muito', 4, toTimestamp(now()));
INSERT INTO comments_ratings(username, puzzle_id, comment, rating, time_of) VALUES ('joao_carlos', 1, 'crazy good', 5, toTimestamp(now()));

-- Insert sample data for liked puzzles
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('joao_silva', 3);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('joao_silva', 6);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('joao_silva', 8);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('joao_silva', 12);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('maria_oliveira', 3);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('maria_oliveira', 6);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('maria_oliveira', 8);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('ana_costa', 7);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('antonio_sousa', 4);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('antonio_sousa', 8);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('catarina_ferreira', 8);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('miguel_monteiro', 4);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('sofia_ribeiro', 1);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('sofia_ribeiro', 8);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('rui_pereira', 10);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('helena_martins', 10);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('joana_almeida', 2);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('hugo_rocha', 12);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('andre_fonseca', 3);
INSERT INTO liked_puzzles(username, puzzle_id) VALUES ('joao_carlos', 1);
