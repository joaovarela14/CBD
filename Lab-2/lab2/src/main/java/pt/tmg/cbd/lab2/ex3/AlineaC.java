package pt.tmg.cbd.lab2.ex3;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import java.util.List;

public class AlineaC {

    public static void main(String[] args) {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");

        MongoDatabase database = mongoClient.getDatabase("cbd");
        MongoCollection<Document> collection_rest = database.getCollection("restaurants");

        // Query to find restaurants with scores between 80 and 100
        System.out.println("\nFinding restaurants with scores between 80 and 100:");
        Document query = new Document("grades", new Document("$elemMatch", new Document("score", new Document("$gte", 80).append("$lte", 100))));
        Document projection = new Document("nome", 1).append("grades", 1).append("_id", 0);
        for (Document doc : collection_rest.find(query).projection(projection)) {
            System.out.println(doc.toJson());
        }

        // List restaurant_id, name, locality, and cuisine of restaurants whose names start with "Wil"
        System.out.println("\nListing restaurants whose names start with 'Wil':");
        Document query2 = new Document("nome", new Document("$regex", "^Wil"));
        Document projection2 = new Document("restaurant_id", 1).append("nome", 1).append("localidade", 1).append("gastronomia", 1).append("_id", 0);
        for (Document doc : collection_rest.find(query2).projection(projection2)) {
            System.out.println(doc.toJson());
        }

        // List name, locality, score, and cuisine of restaurants that always scored less than or equal to 3
        System.out.println("\nListing restaurants that always scored less than or equal to 3:");
        Document query3 = new Document("grades.score", new Document("$not", new Document("$gt", 3)));
        Document projection3 = new Document("nome", 1).append("localidade", 1).append("grades", 1).append("gastronomia", 1).append("_id", 0);
        for (Document doc : collection_rest.find(query3).projection(projection3)) {
            System.out.println(doc.toJson());
        }

        // List restaurant_id, name, and score of restaurants whose second evaluation was grade 'A' and occurred on '2014-08-11'
        System.out.println("\nListing restaurants whose second evaluation was grade 'A' and occurred on '2014-08-11':");
        Document query4 = new Document("grades.1.grade", "A")
                .append("grades.1.date", new Document("$eq", java.time.Instant.parse("2014-08-11T00:00:00Z")));
        Document projection4 = new Document("restaurant_id", 1).append("nome", 1).append("grades", 1).append("_id", 0);
        for (Document doc : collection_rest.find(query4).projection(projection4)) {
            System.out.println(doc.toJson());
        }

        // List restaurant_id, name, and address of restaurants where the second element of coord is greater than 42 and less than or equal to 52
        System.out.println("\nListing restaurants where the second element of coord is greater than 42 and less than or equal to 52:");
        Document query5 = new Document("address.coord.1", new Document("$gt", 42).append("$lte", 52));
        Document projection5 = new Document("restaurant_id", 1).append("nome", 1).append("address", 1).append("_id", 0);
        for (Document doc : collection_rest.find(query5).projection(projection5)) {
            System.out.println(doc.toJson());
        }
    }
}