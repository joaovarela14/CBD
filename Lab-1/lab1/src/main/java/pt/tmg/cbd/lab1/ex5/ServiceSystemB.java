package pt.tmg.cbd.lab1.ex5;

import redis.clients.jedis.Jedis;
import java.util.List;
import java.util.Scanner;


public class ServiceSystemB {

    public Jedis jedis;
    private static final int Unit_limit = 6;
    private static final int timeslot = 60000;
    public int NProducts = 0;

    public ServiceSystemB() {
        this.jedis = new Jedis();
    }

    public void addRequest(String pedido, int t0) {
        int time = (int) System.currentTimeMillis();
        String[] words = pedido.split(";");

        List<String> requests = jedis.zrangeByScore(words[0], time - timeslot, time);

        NProducts += Integer.parseInt(words[2]);
        if(NProducts < Unit_limit) {
            jedis.zadd(words[0], t0, words[1]);
            System.out.println("Pedido do utilizador: " + words[0] + " [produto: " + words[1] + " ,quantidade " + words[2] + "] aceite com sucesso");

            System.out.println();
        } else
            System.err.println("ERROR: Já passou a quantidade de produto permitida nesta janela temporal;");
    }

    public static void main(String[] args) {

        ServiceSystemB board = new ServiceSystemB();

        try (Scanner sc = new Scanner(System.in)) {
            while (true) {
                System.out.println("Insira o seu nome, o seu pedido e a respetiva quantidade, separados por ';', ou escreva 'quit' para sair:");
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
