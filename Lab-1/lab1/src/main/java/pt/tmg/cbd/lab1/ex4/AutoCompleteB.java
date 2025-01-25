package pt.tmg.cbd.lab1.ex4;

import redis.clients.jedis.Jedis;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Scanner;

public class AutoCompleteB {

    public static void main(String[] args) {
        Jedis jedis = new Jedis();
        String filename = "nomes-pt-2021.csv";

        jedis.del("autocompleteb");
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filename));
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
                String name = parts[0];
                jedis.set("autocompleteb:" + name, parts[1]);

                jedis.zadd("autocompleteb", 0, name);
            }
            reader.close();
        } catch (Exception e) {
            System.out.println("Error reading file: " + e);
        }

        System.out.println("Autocomplete loaded with " + jedis.zcard("autocompleteb") + " elements");

        System.out.print("Search for ('Enter' for quit): ");
        Scanner scanner = new Scanner(System.in);
        String searchFor = scanner.nextLine();

        while (!searchFor.isEmpty()) {
            String min = "[" + searchFor;
            String max = "(" + searchFor + Character.MAX_VALUE;

            jedis.zrangeByLex("autocompleteb", min, max).stream()
                    .sorted((name1, name2) -> {
                        int score1 = Integer.parseInt(jedis.get("autocompleteb:" + name1));
                        int score2 = Integer.parseInt(jedis.get("autocompleteb:" + name2));
                        return Integer.compare(score2, score1);
                    })
                    .forEach((name) -> {
                        System.out.println(name + " - " + jedis.get("autocompleteb:" + name));
                    });

            System.out.print("Search for ('Enter' for quit): ");
            searchFor = scanner.nextLine();
        }

        scanner.close();

        jedis.close();
    }
}