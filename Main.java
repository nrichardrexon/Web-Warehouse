package com.warehouse;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

public class Main {
    public static void main(String[] args) {
        int port = getPort();

        String dbUrl = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12741091";
        String user = "sql12741091";
        String password = System.getenv("DB_PASSWORD");

        try (Connection conn = DriverManager.getConnection(dbUrl, user, password)) {
            System.out.println("Database connection successful!");
            startServer(port);
        } catch (SQLException e) {
            System.err.println("Failed to connect to the database. Check your credentials.");
            e.printStackTrace();
            return;
        }
    }

    private static int getPort() {
        String portStr = System.getenv("PORT");
        if (portStr != null) {
            try {
                return Integer.parseInt(portStr);
            } catch (NumberFormatException e) {
                System.err.println("Invalid PORT environment variable. Falling back to default port: 8080");
            }
        }
        return 8080;
    }

    private static void startServer(int port) {
        try {
            HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);
            server.createContext("/", new HttpHandler() {
                @Override
                public void handle(HttpExchange exchange) throws IOException {
                    String uri = exchange.getRequestURI().toString();
                    Path path = Paths.get("src/main/webq", uri);

                    if (Files.exists(path) && !Files.isDirectory(path)) {
                        exchange.sendResponseHeaders(200, Files.size(path));
                        Files.copy(path, exchange.getResponseBody());
                    } else {
                        String response = "404 Not Found";
                        exchange.sendResponseHeaders(404, response.length());
                        exchange.getResponseBody().write(response.getBytes());
                    }
                    exchange.close();
                }
            });
            server.start();
            System.out.println("Server started on port: " + port);
        } catch (IOException e) {
            System.err.println("Failed to start the server.");
            e.printStackTrace();
        }
    }
}
