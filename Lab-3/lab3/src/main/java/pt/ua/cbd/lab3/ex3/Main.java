package pt.ua.cbd.lab3.ex3;

import java.util.Set;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

public class Main {
    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder()
                .withKeyspace("video_share_db")
                .build()) {

            ResultSet rs = session.execute("SELECT release_version FROM system.local");
            Row row = rs.one();
            if (row != null) {
                System.out.println("Cassandra Release Version: " + row.getString("release_version"));
            }

            // delete user if exists
            String deleteUserQuery = "DELETE FROM users WHERE username = 'JavaUser'";
            session.execute(deleteUserQuery);
            System.out.println("User 'JavaUser' deleted.");

            String insertUserQuery = "INSERT INTO users (username, name, email, registration_timestamp) "
                    + "VALUES ('JavaUser', 'Java User', 'java@example.com', toTimestamp(now()))";
            session.execute(insertUserQuery);
            System.out.println("User 'JavaUser' inserted.");

            String searchUserQuery = "SELECT * FROM users WHERE username = 'JavaUser'";
            ResultSet resultSet = session.execute(searchUserQuery);
            Row userRow = resultSet.one();
            if (userRow != null) {
                System.out.println("User found: " +
                        "Username: " + userRow.getString("username") +
                        ", Name: " + userRow.getString("name") +
                        ", Email: " + userRow.getString("email") +
                        ", Registration Timestamp: " + userRow.getInstant("registration_timestamp"));
            } else {
                System.out.println("User 'JavaUser' not found.");
            }


            String updateUserQuery = "UPDATE users SET email = 'newjava@example.com' WHERE username = 'JavaUser'";
            session.execute(updateUserQuery);
            System.out.println("User 'JavaUser' email updated.");

            searchUserQuery = "SELECT * FROM users WHERE username = 'JavaUser'";
            resultSet = session.execute(searchUserQuery);
            userRow = resultSet.one();



            if (userRow != null) {
                System.out.println("User found: " +
                        "Username: " + userRow.getString("username") +
                        ", Name: " + userRow.getString("name") +
                        ", Email: " + userRow.getString("email") +
                        ", Registration Timestamp: " + userRow.getInstant("registration_timestamp"));
            } else {
                System.out.println("User 'JavaUser' not found.");
            }

            insertUserQuery = "INSERT INTO users (username, name, email, registration_timestamp) "
                    + "VALUES ('JavaUser2', 'Java User Two', 'javauser2@example.com', toTimestamp(now()))";
            session.execute(insertUserQuery);
            System.out.println("User 'JavaUser2' inserted.");

            searchUserQuery = "SELECT * FROM users";
            resultSet = session.execute(searchUserQuery);

            System.out.println("\nAll users:");
            for (Row r : resultSet) {
                System.out.println("Username: " + r.getString("username") +
                        ", Name: " + r.getString("name") +
                        ", Email: " + r.getString("email") +
                        ", Registration Timestamp: " + r.getInstant("registration_timestamp"));
            }

            // 1. Os últimos 3 comentários introduzidos para um vídeo
            String query1 = "SELECT comment_id, author, content, timestamp FROM comments_by_video WHERE video_id = 1 LIMIT 3";
            ResultSet resultSet1 = session.execute(query1);
            System.out.println("\nLast 3 comments of video 1:");
            for (Row r : resultSet1) {
                System.out.println("Comment ID: " + r.getInt("comment_id") +
                        ", Author: " + r.getString("author") +
                        ", Comment Timestamp: " + r.getInstant("timestamp") +
                        ", Comment Data: " + r.getString("content"));
            }

            // 2. Lista das tags de determinado vídeo
            String query2 = "SELECT tags FROM videos WHERE video_id = 1;";
            ResultSet resultSet2 = session.execute(query2);
            Row row2 = resultSet2.one();
            if (row2 != null) {
                Set<String> tags = row2.getSet("tags", String.class);
                System.out.println("\nTags of video 1:");
                for (String tag : tags) {
                    System.out.println("Tag: " + tag);
                }
            }

            // 3. Consultar todos os eventos de determinado utilizador:
            String query3 = "SELECT event_id, video_id, event_type, event_timestamp, video_time FROM events_by_user WHERE user_id = 1;";
            ResultSet resultSet3 = session.execute(query3);
            System.out.println("\nAll events of user 1:");
            for (Row r : resultSet3) {
                System.out.println("Event ID: " + r.getInt("event_id") +
                        ", Video ID: " + r.getInt("video_id") +
                        ", Event Type: " + r.getString("event_type") +
                        ", Event Timestamp: " + r.getInstant("event_timestamp") +
                        ", Video Time: " + r.getInt("video_time"));
            }

           // 4. Todos os eventos de determinado utilizador do tipo "pause"
            String query4 = "SELECT event_id, video_id, event_timestamp, video_time FROM pause_events_by_user WHERE user_id = 1;";
            ResultSet resultSet4 = session.execute(query4);
            System.out.println("\nPause events of user 1:");
            for (Row r : resultSet4) {
                System.out.println("Event ID: " + r.getInt("event_id") +
                        ", Video ID: " + r.getInt("video_id") +
                        ", Event Timestamp: " + r.getInstant("event_timestamp") +
                        ", Video Time: " + r.getInt("video_time"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error occurred during Cassandra operations.");
        }
    }
}
