USE puzzle_shop;

-- Adicionar um puzzle resolvido por determinado utilizador
INSERT INTO solved_puzzles (username, puzzle_id, date_solved) VALUES ('miguel_monteiro', 12, '2023-11-29');

-- Atualizar a data em que um puzzle foi resolvido por determinado utilizador
UPDATE solved_puzzles SET date_solved = '2023-11-29' WHERE username = 'miguel_monteiro' AND puzzle_id = 12;

-- Atualizar a data em que um puzzle foi resolvido por determinado utilizador (mudar a data)
-- Remover data em que um puzzle foi resolvido
DELETE FROM solved_puzzles WHERE username = 'miguel_monteiro' AND puzzle_id = 12;
-- Atualizar a data em que um puzzle foi resolvido por determinado utilizador
UPDATE solved_puzzles SET date_solved = '2023-11-30' WHERE username = 'miguel_monteiro' AND puzzle_id = 12;

-- Atualizar puzzles resolvidos por determinado utilizador
DELETE FROM solved_puzzles WHERE username = 'catarina_ferreira';
INSERT INTO solved_puzzles (username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 8, '2023-11-01');
INSERT INTO solved_puzzles (username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 11, '2023-11-02');
INSERT INTO solved_puzzles (username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 5, '2023-11-03');

-- Atualizar tags de um puzzle (remover uma tag)
UPDATE puzzle SET tags = tags - {'people'} WHERE id = 2;


-- Apagar a data em que um puzzle foi resolvido por determinado utilizador
DELETE FROM solved_puzzles WHERE username = 'sofia_ribeiro' AND puzzle_id = 1;

-- Apagar um puzzle resolvido por determinado utilizador
DELETE FROM solved_puzzles WHERE username = 'catarina_ferreira' AND puzzle_id = 2;

-- Apagar uma tag de um puzzle (tag adicionada acima)
DELETE tags['people'] FROM puzzle WHERE id = 2;

-- Apagar um puzzle dos favoritos
DELETE FROM liked_puzzles WHERE username = 'joao_silva' AND puzzle_id = 3;

-- Apagar uma tag de um puzzle
DELETE tags['people'] FROM puzzle WHERE id = 10;

-- 1. Lista de todos os subjects de puzzles
SELECT subject FROM puzzle;

-- 2. Lista de todos os puzzles com a tag city
SELECT id FROM puzzle WHERE tags CONTAINS 'city';

-- 3. Data em que determinado puzzle foi resolvido por determinado utilizador
SELECT date_solved FROM solved_puzzles WHERE username = 'ana_costa' AND puzzle_id = 7;

-- 4. Lista de todos os puzzles com 1000 peças
SELECT * FROM puzzle WHERE piece_number = 1000;

-- 5. Lista de todos os puzzles com rating 4
SELECT puzzle_id FROM comments_ratings WHERE rating = 4;

-- 6. Lista dos últimos 2 comentários num determinado puzzle
SELECT comment FROM comments_ratings WHERE puzzle_id = 6 ORDER BY time_of DESC LIMIT 2;

-- 7. Lista dos puzzles que determinado user gostou
SELECT * FROM liked_puzzles WHERE username = 'joao_silva';

-- 8. Lista das avaliações de determinado puzzle depois de determinada data
SELECT * FROM comments_ratings WHERE puzzle_id = 6 AND time_of > '2023-11-28 00:48:45.087000+0000';

-- 9. Lista do preço e número de peças de todos os puzzles
SELECT id, price, piece_number FROM puzzle;

-- 10. Lista de todos os puzzles resolvidos por determinado utilizador e a data em que foram resolvidos
SELECT date_solved FROM solved_puzzles WHERE username = 'ana_costa';


-- SELECT puzzle_shop.calculate_total_price([20.0, 40.0, 60.0]);


-- SELECT total_price(price) FROM puzzle;
