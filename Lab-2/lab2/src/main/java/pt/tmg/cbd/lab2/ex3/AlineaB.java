package pt.tmg.cbd.lab2.ex3;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

public class AlineaB {
    public static void main(String[] args) {
        final String GREEN = "\u001B[32m";
        final String RED = "\u001B[31m";
        final String RESET = "\u001B[0m";

        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");

        MongoDatabase database = mongoClient.getDatabase("cbd");
        MongoCollection<Document> collection_rest = database.getCollection("restaurants");

        // Pesquisa sem índices de localidade
        long start = System.currentTimeMillis();
        System.out.println(GREEN + "Pesquisa sem índices:" + RESET);
        for (Document doc : collection_rest.find(new Document("localidade", "Brooklyn"))) {
            System.out.println(doc.toJson());
        }
        System.out.println(RED + "Tempo de execução: " + (System.currentTimeMillis() - start) + "ms" + RESET);

        // Pesquisa sem índices de gastronomia
        long start2 = System.currentTimeMillis();
        System.out.println(GREEN + "Pesquisa sem índices:" + RESET);
        for (Document doc : collection_rest.find(new Document("gastronomia", "Portuguese"))) {
            System.out.println(doc.toJson());
        }
        System.out.println(RED + "Tempo de execução: " + (System.currentTimeMillis() - start2) + "ms" + RESET);

        // Pesquisa sem índices por nome
        long start3 = System.currentTimeMillis();
        System.out.println(GREEN + "Pesquisa sem índices:" + RESET);
        for (Document doc : collection_rest.find(new Document("nome", "Restaurante do João"))) {
            System.out.println(doc.toJson());
        }
        System.out.println(RED + "Tempo de execução: " + (System.currentTimeMillis() - start3) + "ms" + RESET);

        // Criar índices
        collection_rest.createIndex(new Document("localidade", 1));
        collection_rest.createIndex(new Document("gastronomia", 1));
        collection_rest.createIndex(new Document("nome", "text"));

        // Testar pesquisas
        long start4 = System.currentTimeMillis();
        System.out.println(GREEN + "Pesquisa por localidade:" + RESET);
        for (Document doc : collection_rest.find(new Document("localidade", "Brooklyn"))) {
            System.out.println(doc.toJson());
        }
        System.out.println(RED + "Tempo de execução: " + (System.currentTimeMillis() - start4) + "ms" + RESET);

        long start5 = System.currentTimeMillis();
        System.out.println(GREEN + "Pesquisa por gastronomia:" + RESET);
        for (Document doc : collection_rest.find(new Document("gastronomia", "Portuguese"))) {
            System.out.println(doc.toJson());
        }
        System.out.println(RED + "Tempo de execução: " + (System.currentTimeMillis() - start5) + "ms" + RESET);

        long start6 = System.currentTimeMillis();
        System.out.println(GREEN + "Pesquisa por nome (texto):" + RESET);
        for (Document doc : collection_rest.find(new Document("$text", new Document("$search", "Restaurante do João")))) {
            System.out.println(doc.toJson());
        }
        System.out.println(RED + "Tempo de execução: " + (System.currentTimeMillis() - start6) + "ms" + RESET);
    }
}