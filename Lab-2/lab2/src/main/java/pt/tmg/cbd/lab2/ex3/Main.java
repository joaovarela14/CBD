package pt.tmg.cbd.lab2.ex3;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import com.mongodb.client.model.Filters;

public class Main {
    public static void main(String[] args) {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");

        MongoDatabase database = mongoClient.getDatabase("cbd");
        MongoCollection<Document> collection_rest = database.getCollection("restaurantes");

        // se houver database e coleçao retorna tudo certo
        System.out.println("Database: " + database.getName());
        System.out.println("Collection: " + collection_rest.getNamespace().getCollectionName());

        //INSERT
        Document newRestaurant = new Document("nome", "Restaurante do João")
                .append("gastronomia", "Italiana")
                .append("address", new Document("rua", "Rua das Flores")
                        .append("zipcode", "987-6543"))
                .append("localidade", "Lisboa");

        collection_rest.insertOne(newRestaurant);

        System.out.println("Restaurante inserido: " );
        System.out.println(collection_rest.find(new Document("nome", "Restaurante do João")).first().toJson());

        //EDIT
        Document query = new Document("nome", "Restaurante do João");
        Document update = new Document("$set", new Document("localidade", "Porto"));
        collection_rest.updateOne(query, update);

        System.out.println("Restaurante editado: ");
        System.out.println(collection_rest.find(new Document("nome", "Restaurante do João")).first().toJson());

        //SEARCH
        System.out.println("Restaurante pesquisado: ");
        System.out.println(collection_rest.find(new Document("localidade", "Porto")).first().toJson());

    }


}