package pt.tmg.cbd.lab1.ex4;

import java.util.*;
import java.io.*;
import redis.clients.jedis.Jedis;

public class AutoCompleteA {
    public static void main(String[] args) {
        // TODO: Complete me
        String key = "names";
        Jedis jedis = new Jedis();
        Scanner scanner = new Scanner(System.in);

        try {
            BufferedReader br = new BufferedReader(new FileReader("names.txt"));
            String line;

            while ((line = br.readLine()) != null) {
                jedis.zadd(key, 0, line.toLowerCase());
            }

            br.close();
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }

        while (true) {
            System.out.println("\nEnter a search term ('Enter' for quit): ");
            String search = scanner.nextLine();
            if (search.isEmpty()) {
                break;
            }

            search = search.toLowerCase();
            System.out.println("Results for '" + search + "':");

            List<String> results = jedis.zrangeByLex(key, "[" + search, "[" + search + "\uFFFF");

            if (results.isEmpty()) {
                System.out.println("No results found.");
            } else {
                results.stream().forEach(System.out::println);
            }
        }

        scanner.close();
        jedis.close();
    }
}
