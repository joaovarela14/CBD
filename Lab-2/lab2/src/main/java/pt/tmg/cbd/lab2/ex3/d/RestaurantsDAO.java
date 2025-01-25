package pt.tmg.cbd.lab2.ex3.d;

import com.mongodb.client.*;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RestaurantsDAO {

    private final MongoCollection<Document> mongoCollection;

    public RestaurantsDAO(MongoCollection<Document> mongoCollection) {
        this.mongoCollection = mongoCollection;
    }

    // Corrected countLocalidades method
    public int countLocalidades() {
        AggregateIterable<Document> aggregate = mongoCollection.aggregate(List.of(
                Aggregates.group("$localidade"),
                Aggregates.count("numLocalidades")
        ));

        Document result = aggregate.first();
        if (result != null) {
            return result.getInteger("numLocalidades");
        } else {
            return 0;
        }
    }

    public Map<String, Integer> countRestByLocalidade() {
        Map<String, Integer> resultMap = new HashMap<>();

        AggregateIterable<Document> aggregate = mongoCollection.aggregate(List.of(
                Aggregates.group("$localidade",
                        Accumulators.sum("numRest", 1))
        ));

        for (Document doc : aggregate) {
            String localidade = doc.getString("_id");
            int numRest = doc.getInteger("numRest");
            resultMap.put(localidade, numRest);
        }

        return resultMap;
    }

    public List<String> getRestWithNameCloserTo(String name) {
        List<String> restaurants = new ArrayList<>();
        Bson regexFilter = Filters.regex("nome", ".*" + name + ".*", "i");
        FindIterable<Document> matchingRestaurants = mongoCollection.find(regexFilter);
        for (Document restaurant : matchingRestaurants) {
            restaurants.add(restaurant.getString("nome"));
        }
        return restaurants;
    }

    public static void main(String[] args) {
        // Connecting to MongoDB
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("cbd");
        MongoCollection<Document> collection = database.getCollection("restaurants");


        RestaurantsDAO restaurantsDAO = new RestaurantsDAO(collection);

        int totalLocalidades = restaurantsDAO.countLocalidades();
        System.out.println("\nTotal de localidades: " + totalLocalidades);

        Map<String, Integer> restByLocalidade = restaurantsDAO.countRestByLocalidade();
        System.out.println("\nTotal de restaurantes por localidade: ");
        restByLocalidade.forEach((localidade, count) ->
                System.out.println("\t" + localidade + ": " + count + " restaurantes")
        );


        List<String> restaurantsWithName = restaurantsDAO.getRestWithNameCloserTo("Park");
        System.out.println("\nNome de restaurantes contendo 'Park' no nome:");
        for (String restName : restaurantsWithName) {
            System.out.println("-> " + restName);
        }


        mongoClient.close();
    }
}
