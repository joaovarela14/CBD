package pt.tmg.cbd.lab1.ex5;

import redis.clients.jedis.Jedis;
import java.util.List;
import java.util.Scanner;

public class ServiceSystemA {

    public Jedis jedis;
    private static final int LIMIT = 2;
    private static final int TIMESLOT = 30000;

    public ServiceSystemA() {
        this.jedis = new Jedis();
    }

    public void addRequest(String pedido, int t0) {
        int currentTime = (int) System.currentTimeMillis();
        String[] words = pedido.split(";");

        List<String> requests = jedis.zrangeByScore(words[0], currentTime - TIMESLOT, currentTime);

        if (requests.size() < LIMIT) {
            jedis.zadd(words[0], t0, words[1]);
            System.out.println("Pedido do utilizador: " + words[0] + " [produto: " + words[1] + "] aceite com sucesso\n");
        } else {
            System.err.println("ERROR: Já passou o número de pedidos nesta janela temporal.");
        }
    }

    public static void main(String[] args) {
        ServiceSystemA board = new ServiceSystemA();
        try (Scanner sc = new Scanner(System.in)) {
            while (true) {
                System.out.println("Insira o seu nome e o seu pedido, separados por ';', ou escreva 'quit' para sair:");
                String input = sc.nextLine().trim();

                if ("quit".equalsIgnoreCase(input)) {
                    System.out.println("Saindo...");
                    System.exit(0);
                }

                if (input.isEmpty()) {
                    System.out.println("Não inseriu nenhum valor no seu pedido");
                    continue;
                }

                int currentTime = (int) System.currentTimeMillis();
                board.addRequest(input, currentTime);
            }
        }
    }
}
