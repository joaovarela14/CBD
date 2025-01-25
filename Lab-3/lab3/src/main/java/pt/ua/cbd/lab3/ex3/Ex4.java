package pt.ua.cbd.lab3.ex3;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

public class Ex4 {
    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder().build()) {
            // Inserir um puzzle resolvido por um determinado utilizador
            session.execute("INSERT INTO puzzle_shop.solved_puzzles (username, puzzle_id, date_solved) VALUES ('miguel_monteiro', 12, '2023-11-29')");

            // Atualizar a data em que um puzzle foi resolvido
            session.execute("UPDATE puzzle_shop.solved_puzzles SET date_solved = '2023-11-29' WHERE username = 'miguel_monteiro' AND puzzle_id = 12");

            // Remover a data em que um puzzle foi resolvido e depois adicionar novamente com nova data
            session.execute("DELETE FROM puzzle_shop.solved_puzzles WHERE username = 'miguel_monteiro' AND puzzle_id = 12");
            session.execute("UPDATE puzzle_shop.solved_puzzles SET date_solved = '2023-11-30' WHERE username = 'miguel_monteiro' AND puzzle_id = 12");

            // Atualizar puzzles resolvidos por determinado utilizador
            session.execute("DELETE FROM puzzle_shop.solved_puzzles WHERE username = 'catarina_ferreira'");
            session.execute("INSERT INTO puzzle_shop.solved_puzzles (username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 8, '2023-11-01')");
            session.execute("INSERT INTO puzzle_shop.solved_puzzles (username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 11, '2023-11-02')");
            session.execute("INSERT INTO puzzle_shop.solved_puzzles (username, puzzle_id, date_solved) VALUES ('catarina_ferreira', 5, '2023-11-03')");

            // Atualizar tags de um puzzle
            session.execute("UPDATE puzzle_shop.puzzle SET tags = tags - {'people'} WHERE id = 2");

            // Apagar a data em que um puzzle foi resolvido por determinado utilizador
            session.execute("DELETE FROM puzzle_shop.solved_puzzles WHERE username = 'sofia_ribeiro' AND puzzle_id = 1");

            // Apagar um puzzle resolvido por determinado utilizador
            session.execute("DELETE FROM puzzle_shop.solved_puzzles WHERE username = 'catarina_ferreira' AND puzzle_id = 2");

            // Apagar uma tag de um puzzle
            session.execute("DELETE tags['people'] FROM puzzle_shop.puzzle WHERE id = 2");

            // Apagar um puzzle dos favoritos
            session.execute("DELETE FROM puzzle_shop.liked_puzzles WHERE username = 'joao_silva' AND puzzle_id = 3");

            // Queries de exemplo
            // 1. Lista de todos os subjects de puzzles
            ResultSet rs1 = session.execute("SELECT subject FROM puzzle_shop.puzzle");
            for (Row row : rs1) {
                System.out.println("Subject: " + row.getString("subject"));
            }

            // 2. Lista de todos os puzzles com a tag 'city'
            ResultSet rs2 = session.execute("SELECT id FROM puzzle_shop.puzzle WHERE tags CONTAINS 'city'");
            for (Row row : rs2) {
                System.out.println("Puzzle ID: " + row.getInt("id"));
            }

            // 3. Data em que determinado puzzle foi resolvido por determinado utilizador
            ResultSet rs3 = session.execute("SELECT date_solved FROM puzzle_shop.solved_puzzles WHERE username = 'ana_costa' AND puzzle_id = 7");
            for (Row row : rs3) {
                System.out.println("Date Solved: " + row.getLocalDate("date_solved"));
            }

            // 4. Lista de todos os puzzles com 1000 peças
            ResultSet rs4 = session.execute("SELECT * FROM puzzle_shop.puzzle WHERE piece_number = 1000");
            for (Row row : rs4) {
                System.out.println("Puzzle: " + row.getInt("id") + ", Subject: " + row.getString("subject") + ", Price: " + row.getFloat("price"));
            }

            // 5. Lista de todos os puzzles com rating 4
            ResultSet rs5 = session.execute("SELECT puzzle_id FROM puzzle_shop.comments_ratings WHERE rating = 4");
            for (Row row : rs5) {
                System.out.println("Puzzle ID with Rating 4: " + row.getInt("puzzle_id"));
            }

            // 6. Lista dos últimos 2 comentários num determinado puzzle
            ResultSet rs6 = session.execute("SELECT comment FROM puzzle_shop.comments_ratings WHERE puzzle_id = 6 ORDER BY time_of DESC LIMIT 2");
            for (Row row : rs6) {
                System.out.println("Comment: " + row.getString("comment"));
            }

            // 7. Lista dos puzzles que determinado user gostou
            ResultSet rs7 = session.execute("SELECT * FROM puzzle_shop.liked_puzzles WHERE username = 'joao_silva'");
            for (Row row : rs7) {
                System.out.println("Liked Puzzle ID: " + row.getInt("puzzle_id"));
            }

            // 8. Lista das avaliações de determinado puzzle depois de determinada data
            ResultSet rs8 = session.execute("SELECT * FROM puzzle_shop.comments_ratings WHERE puzzle_id = 6 AND time_of > '2023-11-28 00:48:45.087000+0000'");
            for (Row row : rs8) {
                System.out.println("Comment: " + row.getString("comment") + ", Rating: " + row.getInt("rating") + ", Time: " + row.getInstant("time_of"));
            }

            // 9. Lista do preço e número de peças de todos os puzzles
            ResultSet rs9 = session.execute("SELECT id, price, piece_number FROM puzzle_shop.puzzle");
            for (Row row : rs9) {
                System.out.println("Puzzle ID: " + row.getInt("id") + ", Price: " + row.getFloat("price") + ", Piece Number: " + row.getInt("piece_number"));
            }

            // 10. Lista de todos os puzzles resolvidos por determinado utilizador e a data em que foram resolvidos
            ResultSet rs10 = session.execute("SELECT puzzle_id, date_solved FROM puzzle_shop.solved_puzzles WHERE username = 'ana_costa'");
            for (Row row : rs10) {
                System.out.println("Puzzle ID: " + row.getInt("puzzle_id") + ", Date Solved: " + row.getLocalDate("date_solved"));
            }
        }
    }
}
