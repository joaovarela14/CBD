USE video_share_db;

// 7. Permitir a pesquisa de todos os videos de determinado autor;
SELECT * FROM videos WHERE author = 'john_doe';

// 8. Permitir a pesquisa de comentarios por utilizador, ordenado inversamente pela data;
SELECT * FROM comments_by_user WHERE author = 'charlie_lee';

// 9. Permitir a pesquisa de comentarios por videos, ordenado inversamente pela data;
SELECT * FROM comments_by_video WHERE video_id = 1;

// 10. Permitir a pesquisa do rating medio de um video e quantas vezes foi votado;
SELECT
    video_id,
    SUM(rating) / CAST(COUNT(*) AS DOUBLE) AS average_rating,
    COUNT(*) AS total_votes
FROM video_ratings WHERE video_id = 2;



// 1. Os ultimos 3 comentarios introduzidos para um video;
SELECT * FROM comments_by_video WHERE video_id = 1 LIMIT 3;

// 2. Lista das tags de determinado video;
SELECT tags FROM videos WHERE video_id = 1;

// 3. Todos os videos com a tag Aveiro;
SELECT * FROM videos WHERE tags CONTAINS 'Aveiro';

// 4.a. Os últimos 5 eventos de determinado vídeo realizados por um utilizador;
SELECT * FROM events WHERE video_id = 1 AND user_id = 1 LIMIT 5;

// 4.b. Consultar todos os eventos de determinado utilizador:
SELECT * FROM events_by_user WHERE user_id = 1;

-- Para suportar esta consulta, foi necessário criar uma tabela auxiliar,
-- pois na tabela original `events`, a partition key é composta por (video_id, user_id),
-- o que impede consultas eficientes apenas com base em `user_id`.
-- CREATE TABLE events_by_user (
--     user_id int,
--     event_timestamp timestamp,
--     event_id int,
--     video_id int,
--     event_type text,
--     video_time int,
--     PRIMARY KEY (user_id, event_timestamp)
-- ) WITH CLUSTERING ORDER BY (event_timestamp DESC);

-- Nesta tabela, `user_id` é a partition key, permitindo consultas eficientes
-- de todos os eventos associados a um determinado utilizador.


// 4.c. Todos os eventos de determinado utilizador do tipo "pause"
SELECT * FROM pause_events_by_user WHERE user_id = 1;
-- Para suportar esta consulta, foi necessário criar uma tabela auxiliar,
-- pois Cassandra não suporta operações JOIN nem filtros em colunas que não fazem parte
-- da partition key.

-- CREATE TABLE pause_events_by_user (
--     user_id int,
--     event_timestamp timestamp,
--     event_id int,
--     video_id int,
--     video_time int,
--     PRIMARY KEY (user_id, event_timestamp)
-- ) WITH CLUSTERING ORDER BY (event_timestamp DESC);

-- Nesta tabela, apenas eventos do tipo "pause" são armazenados.
-- é necessária para consultas por `user_id`
-- e filtrar diretamente eventos do tipo "pause".


// 5. Videos partilhados por determinado utilizador (maria1987, por exemplo) num determinado periodo de tempo (Agosto de 2017, por exemplo);
SELECT *
FROM videos_by_author
WHERE author = 'john_doe'
  AND upload_timestamp >= '2020-01-01'
  AND upload_timestamp < '2020-05-01';

-- Para suportar esta consulta, foi necessário criar uma tabela auxiliar,
-- pois na tabela original `videos`, a partition key é `video_id`, o que não permite consultas eficientes
-- apenas com base no autor e num intervalo de tempo.
-- CREATE TABLE videos_by_author (
--     author text,
--     upload_timestamp timestamp,
--     video_id int,
--     name text,
--     description text,
--     tags set<text>,
--     PRIMARY KEY (author, upload_timestamp)
-- ) WITH CLUSTERING ORDER BY (upload_timestamp DESC);

-- Nesta tabela auxiliar, `author` é a partition key, permitindo consultas eficientes para
-- vídeos partilhados por um autor específico dentro de um intervalo de tempo.
-- Essa abordagem de denormalização é necessária devido ao facto de Cassandra não suportar operações JOIN.

// 6. Os ultimos 10 videos, ordenado inversamente pela data da partilhada;
SELECT * FROM videos LIMIT 10;
 -- Cassandra não suporta consultas globais ordenadas sem especificar uma partição.
 -- Como não restringimos à partition key tem de se criar uma tabela auxiliar

// 7. Todos os seguidores (followers) de determinado video;
SELECT * FROM video_followers WHERE video_id = 1;

-- Foi necessário criar uma tabela auxiliar,
-- já que a tabela original `videos` não armazena informações de seguidores diretamente
-- e Cassandra não suporta operações JOIN.

-- CREATE TABLE video_followers (
--     video_id int,
--     follower_id int,
--     follow_timestamp timestamp,
--     PRIMARY KEY (video_id, follower_id)
-- );

-- Nesta tabela:
-- - `video_id` é a partition key, permitindo consultas de todos os seguidores
--   para um determinado vídeo.
-- - `follower_id` é usado como clustering key para identificar cada seguidor de forma única
--   dentro de uma partição.
-- - O campo `follow_timestamp` é opcional e pode ser usado para armazenar a data e ou hora em que o vídeo foi seguido.


// 8. Todos os comentarios (dos videos) que determinado utilizador esta a seguir (following);
-- Esta consulta não pode ser realizada diretamente porque Cassandra não suporta operações JOIN,
-- e os dados necessários estão distribuídos em várias tabelas.
-- Teriamos de criar uma tabela que nos desse uma associação entre o vídeo e o utilizador que o segue.
-- Outra tabela para armazenar os comentários

// 9. Os 5 videos com maior rating;
-- Não é possível, pois, apesar da tabela video_ratings estar ordenada por rating, a partition key é video_id (necessária para a alínea a10).
-- Isso provoca a distribuição dos dados por diferentes partições (baseada no video_id), impossibilitando uma ordenação global.
-- Dessa forma, apenas é possível ordenar os dados dentro da mesma partição (ou seja, dentro de um único video_id), mas não de forma global entre todos os vídeos.


// 10. Uma query que retorne todos os videos e que mostre claramente a forma pela qual estao ordenados;
SELECT * FROM videos;
-- Pelo mesmo motivo mencionado anteriormente, embora a query retorne todos os vídeos, como a partition key é video_id, os dados são distribuídos por diferentes partições baseadas no video_id.
-- Isso significa que não há uma ordenação evidente ou global entre todos os vídeos retornados, já que a ordenação ocorre apenas dentro de cada partição individual.
-- Para resolver este problema e obter uma ordenação de vídeos
-- seria necessário criar uma tabela auxiliar


// 11. Lista com as Tags existentes e o numero de videos catalogados com cada uma delas;
-- Seria necessário criar mais tabelas para resolver esta querie, pois Cassandra não suporta operações JOIN
-- Uma tabela que armazene a relação entre tags e vídeos.
-- CREATE TABLE tags_videos (
--     tag text,
--     video_id int,
--     PRIMARY KEY (tag, video_id)
-- tag é a chave de partição, permitindo consultas de todos os vídeos com uma tag específica.


-- Para as queries abaixo, foi necessário criar uma tabela auxiliar para resolver esta querie, tal como pedido. 
-- Coloquei as no final do ficheiro DDL

// 12. Quais são os vídeos mais visualizados por um determinado utilizador?
SELECT * FROM video_views_by_user WHERE user_id = 1;

// 13. Quais são os vídeos mais comentados?
SELECT * FROM video_comment_count;

// 14. Quais são os vídeos mais recentes de um determinado autor?
SELECT * FROM recent_videos_by_author WHERE author = 'john_doe';

