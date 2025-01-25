package pt.tmg.cbd.lab2.ex4;

import java.util.List;
import org.bson.Document;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class SistemaAtendimentoQty {
    private static int limit = 30;
    private static int timeslot = 3600;
    private final MongoCollection<Document> users;

    public SistemaAtendimentoQty(MongoDatabase database) {
        this.users = database.getCollection("users");
    }

    public void registrarProduto(String user, String produto, int qty) {
        long currentTime = getCurrentTimeInSeconds();
        long maxTime = currentTime + timeslot;
        long currentQuantity = getProductQuantity(user, produto, currentTime);

        removeExpiredProducts(user);

        if (currentQuantity + qty > limit) {
            System.err.println("Limite de produtos atingido para o utilizador " + user + "! (tentou adicionar " + qty
                    + " mas já tem " + currentQuantity + ")");
        } else {
            Document product = new Document("produto", produto)
                    .append("timestamp", maxTime)
                    .append("qty", qty);

            Document userProduct = new Document("user", user)
                    .append("produtos", List.of(product));

            users.insertOne(userProduct);

            System.out.println("Produto " + produto + " registado para o utilizador " + user + " | +" + qty
                    + " unidades (" + (currentQuantity + qty) + " no total)");
        }
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

    public void removeExpiredProducts(String user) {
        long currentTime = getCurrentTimeInSeconds();
        Document removeFilter = new Document("user", user)
                .append("produtos.timestamp", new Document("$lte", currentTime));

        users.deleteMany(removeFilter);
    }

    public String getAllProducts(String user) {
        removeExpiredProducts(user);
        Document filter = new Document("user", user);
        Iterable<Document> docs = users.find(filter);
        StringBuilder result = new StringBuilder();

        for (Document doc : docs) {
            List<Document> produtos = (List<Document>) doc.get("produtos");
            for (Document prod : produtos) {
                long timeToExpire = prod.getLong("timestamp") - getCurrentTimeInSeconds();
                result.append(prod.getString("produto"))
                        .append(" Qty: ")
                        .append(prod.getInteger("qty"))
                        .append(" Time to expire (s): ")
                        .append(timeToExpire)
                        .append("\n");
            }
        }
        return result.toString();
    }

    private long getCurrentTimeInSeconds() {
        return System.currentTimeMillis() / 1000;
    }

    private long getProductQuantity(String user, String produto, long currentTime) {
        Document filter = new Document("user", user)
                .append("produtos.timestamp", new Document("$gt", currentTime));

        Iterable<Document> docs = users.find(filter);
        long quantity = 0;

        for (Document doc : docs) {
            List<Document> produtos = (List<Document>) doc.get("produtos");
            for (Document prod : produtos) {
                if (prod.getString("produto").equals(produto)) {
                    quantity += prod.getInteger("qty");
                }
            }
        }
        return quantity;
    }
}
