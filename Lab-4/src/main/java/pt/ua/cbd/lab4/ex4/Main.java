package pt.ua.cbd.lab4.ex4;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import org.neo4j.driver.*;

public class Main {

    private static final String URI = "bolt://localhost:7687";
    private static final String USERNAME = "neo4j";
    private static final String PASSWORD = "youtubecbd";

    private static void loadCsvData(Session session, String csvPath) {
        String query = """
            LOAD CSV WITH HEADERS FROM $csvPath AS row
            WITH row WHERE row.Youtuber IS NOT NULL AND row.Youtuber <> ""
            MERGE (y:Youtuber {name: row.Youtuber})
            SET y.rank = toInteger(row.rank),
                y.subscribers = toInteger(row.subscribers),
                y.video_views = toInteger(row.`video views`),
                y.category = row.category,
                y.title = row.Title,
                y.uploads = toInteger(row.uploads),
                y.country = row.Country,
                y.channel_type = row.channel_type,
                y.video_views_rank = toInteger(row.video_views_rank),
                y.channel_type_rank = toInteger(row.channel_type_rank);
        """;

        // Corrigir caminho do CSV para uso com Neo4j
        csvPath = "file:///" + csvPath;
        session.run(query, Values.parameters("csvPath", csvPath));
        System.out.println("Dados carregados no Neo4j com sucesso.");
    }   public static void main(String... args) {
        String outputFilePath = "CBD_L44c_output.txt";
        String csvPath = args.length > 0 ? args[0] : "resources/stats.csv";

        try (Driver driver = GraphDatabase.driver(URI, AuthTokens.basic(USERNAME, PASSWORD));
             BufferedWriter writer = new BufferedWriter(new FileWriter(outputFilePath))) {

            System.out.println("Conectado ao Neo4j com sucesso.");

            try (Session session = driver.session()) {
                loadCsvData(session, csvPath); // Call the method to load CSV data

                // Top 10 Youtubers por Subscritores
                writer.write("Top 10 Youtubers por Subscritores:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.rank AS rank, n.name AS Youtuber, n.subscribers AS subscribers, n.category AS category
                    ORDER BY n.subscribers DESC
                    LIMIT 10
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Rank: %d, Youtuber: %s, Subscritores: %d, Categoria: %s\n",
                                record.get("rank").asLong(),
                                record.get("Youtuber").asString(),
                                record.get("subscribers").asLong(),
                                record.get("category").asString()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Categorias mais populares por visualizações totais
                writer.write("\n10 Categorias mais populares por visualizações totais:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.category AS category, SUM(n.`video_views`) AS total_video_views
                    ORDER BY total_video_views DESC
                    LIMIT 10
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Categoria: %s, Visualizações Totais: %d\n",
                                record.get("category").asString(),
                                record.get("total_video_views").asLong()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Países com mais Youtubers
                writer.write("\n10 Países com mais Youtubers:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.country AS country, COUNT(*) AS total_channels
                    ORDER BY total_channels DESC
                    LIMIT 10
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("País: %s, Total de Canais: %d\n",
                                record.get("country").asString(),
                                record.get("total_channels").asLong()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Tipos de canal mais populares com base em uploads
                writer.write("\nTipos de canal mais populares com base em uploads:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.channel_type AS channel_type, SUM(n.uploads) AS total_uploads
                    ORDER BY total_uploads DESC
                    LIMIT 5
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Tipo de Canal: %s, Uploads Totais: %d\n",
                                record.get("channel_type").asString(),
                                record.get("total_uploads").asLong()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Canais com mais visualizações por subscritor
                writer.write("\n10 Canais com mais visualizações por subscritor:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.name AS Youtuber, n.subscribers AS subscribers, n.`video_views` AS video_views, 
                           (toFloat(n.`video_views`) / n.subscribers) AS views_per_subscriber
                    ORDER BY views_per_subscriber DESC
                    LIMIT 10
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Youtuber: %s, Visualizações por Subscritor: %.2f\n",
                                record.get("Youtuber").asString(),
                                record.get("views_per_subscriber").asDouble()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Rank médio por categoria
                writer.write("\nTop 10 Rank médio por categoria:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.category AS category, AVG(n.rank) AS avg_rank
                    ORDER BY avg_rank ASC
                    LIMIT 10
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Categoria: %s, Rank Médio: %.2f\n",
                                record.get("category").asString(),
                                record.get("avg_rank").asDouble()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });


                // Tipos de canal com mais subscritores acumulados
                writer.write("\nTop 5 canais com mais subscritores acumulados:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.channel_type AS channel_type, SUM(n.subscribers) AS total_subscribers
                    ORDER BY total_subscribers DESC
                    LIMIT 5
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Tipo de Canal: %s, Subscritores Totais: %d\n",
                                record.get("channel_type").asString(),
                                record.get("total_subscribers").asLong()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Canais mais bem classificados com base em tipo de canal
                writer.write("\n5 Canais mais bem classificados com base em tipo de canal:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.channel_type AS channel_type, MIN(n.rank) AS best_rank
                    ORDER BY best_rank ASC
                    LIMIT 5
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Tipo de Canal: %s, Melhor Rank: %d\n",
                                record.get("channel_type").asString(),
                                record.get("best_rank").asLong()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Número de Youtubers em cada país, agrupados por tipo de canal
                writer.write("\nTop 20 Youtubers em cada país, agrupados por tipo de canal:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    RETURN n.country AS country, n.channel_type AS channel_type, COUNT(*) AS total_channels
                    ORDER BY total_channels DESC, country ASC
                    LIMIT 20
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("País: %s, Tipo de Canal: %s, Total de Canais: %d\n",
                                record.get("country").asString(),
                                record.get("channel_type").asString(),
                                record.get("total_channels").asLong()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });

                // Youtubers com a maior média de visualizações por vídeo
                writer.write("\nTop 10 Youtubers com a maior média de visualizações por vídeo:\n");
                session.run("""
                    MATCH (n:Youtuber)
                    WHERE n.uploads > 0
                    RETURN n.name AS Youtuber, n.uploads AS uploads, n.video_views AS video_views, 
                        (toFloat(n.video_views) / n.uploads) AS views_per_video
                    ORDER BY views_per_video DESC
                    LIMIT 10
                """).list().forEach(record -> {
                    try {
                        writer.write(String.format("Youtuber: %s, Uploads: %d, Visualizações: %d, Média de Visualizações por Vídeo: %.2f\n",
                                record.get("Youtuber").asString(),
                                record.get("uploads").asLong(),
                                record.get("video_views").asLong(),
                                record.get("views_per_video").asDouble()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });
            }

            System.out.println("Resultados gravados no ficheiro: " + outputFilePath);

        } catch (IOException | RuntimeException e) {
            System.err.println("Erro: " + e.getMessage());
        }
    }
    
    
}
