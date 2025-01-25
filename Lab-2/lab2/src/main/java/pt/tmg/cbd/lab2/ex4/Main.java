package pt.tmg.cbd.lab2.ex4;
import java.util.Scanner;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class Main {
    public static void main(String[] args) {
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("sistema_atendimento");
            database.drop();

            Scanner scanner = new Scanner(System.in);
            System.out.print("Qual a opção? (a ou b): ");
            String input = scanner.nextLine();
            long start;

            switch (input.toLowerCase()) {
                case "a":
                    executarA(database);
                    break;

                case "b":
                    executarB(database);
                    break;

                default:
                    System.out.println("Opção inválida.");
                    break;
            }

            scanner.close();
        }
    }

    private static void executarA(MongoDatabase database) {
        SistemaAtendimento sistema = new SistemaAtendimento(database);
        SistemaAtendimento.setLimit(5);
        SistemaAtendimento.setTimeslot(7);

        String user1 = "Joao";
        String user2 = "Maria";


        for (int i = 0; i < 8; i++) {
            sistema.registrarProduto(user1, "Produto" + i);
            dormir(1000);
        }


        for (int i = 0; i < 10; i++) {
            sistema.registrarProduto(user2, "Produto" + i);
            dormir(1000);
        }


        for (int i = 0; i < 3; i++) {
            sistema.registrarProduto(user1, "Produto" + i);
            dormir(1000);
        }
    }

    private static void executarB(MongoDatabase database) {
        SistemaAtendimentoQty sistemaQty = new SistemaAtendimentoQty(database);
        SistemaAtendimentoQty.setLimit(5);
        SistemaAtendimentoQty.setTimeslot(4);

        String user1Qty = "Joao";


        for (int i = 1; i <= 3; i++) {
            long start = System.nanoTime();
            sistemaQty.registrarProduto(user1Qty, "Produto" + i, i);
            System.out.println("Tempo de execução ao registrar produto: " + (System.nanoTime() - start) / 1000000 + "ms");
            dormir(1000);
        }


        sistemaQty.registrarProduto(user1Qty, "ProdutoX", 3);
        dormir(10000);
        sistemaQty.registrarProduto(user1Qty, "ProdutoY", 3);


        long start = System.nanoTime();
        System.out.println(sistemaQty.getAllProducts(user1Qty));
        System.out.println("Tempo de execução ao ler todos os produtos: " + (System.nanoTime() - start) / 1000000 + "ms");

        dormir(3000);


        sistemaQty.registrarProduto(user1Qty, "ProdutoY", 2);
        System.out.println(sistemaQty.getAllProducts(user1Qty));

        dormir(3000);

        start = System.nanoTime();
        System.out.println(sistemaQty.getAllProducts(user1Qty));
        System.out.println("Tempo de execução ao ler todos os produtos: " + (System.nanoTime() - start) / 1000000 + "ms");
    }


    private static void dormir(int milissegundos) {
        try {
            Thread.sleep(milissegundos);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
