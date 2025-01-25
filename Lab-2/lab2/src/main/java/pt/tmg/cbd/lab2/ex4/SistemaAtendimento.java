package pt.tmg.cbd.lab2.ex4;

import java.util.List;
import org.bson.Document;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class SistemaAtendimento {
    private static int limit = 30;
    private static int timeslot = 3600;
    private final MongoCollection<Document> users;

    public SistemaAtendimento(MongoDatabase database) {
        this.users = database.getCollection("users");
    }

    public void registrarProduto(String user, String produto) {
        long currentTime = getCurrentTimeInSeconds();
        long maxTime = currentTime + timeslot;

        Document activeProductFilter = new Document("user", user)
                .append("produtos.timestamp", new Document("$gt", currentTime));

        long activeProductCount = users.countDocuments(activeProductFilter);

        Document expiredProductFilter = new Document("user", user)
                .append("produtos.timestamp", new Document("$lte", currentTime));
        users.deleteMany(expiredProductFilter);

        if (activeProductCount >= limit) {
            System.err.println("Limite de produtos atingido para o utilizador " + user + "!");
        } else {
            Document product = new Document("produto", produto).append("timestamp", maxTime);
            Document userProduct = new Document("user", user).append("produtos", List.of(product));

            users.insertOne(userProduct);
            System.out.println("Produto " + produto + " registado para o utilizador " + user);
        }
    }

    private long getCurrentTimeInSeconds() {
        return System.currentTimeMillis() / 1000;
    }

    public static void setLimit(int newLimit) {
        limit = newLimit;
        System.out.println("Limite alterado para " + newLimit + " produtos.");
    }

    public static void setTimeslot(int newTimeslot) {
        timeslot = newTimeslot;
        System.out.println("Timeslot alterado para " + newTimeslot + " segundos.");
    }

    public static int getLimit() {
        return limit;
    }

    public static int getTimeslot() {
        return timeslot;
    }
}
