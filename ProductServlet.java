package com.warehouse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12741091";
    private static final String DB_USERNAME = "sql12741091";
    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productName = request.getParameter("name");
        String quantityStr = request.getParameter("quantity");
        String priceStr = request.getParameter("price");
        String availableStr = request.getParameter("available");

        if (productName == null || quantityStr == null || priceStr == null || availableStr == null) {
            response.sendRedirect("./error.jsp?message=Missing+input+fields");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                 PreparedStatement statement = connection.prepareStatement(
                         "INSERT INTO product (productName, quantity, price, availableStock) VALUES (?, ?, ?, ?)")) {
                statement.setString(1, productName);
                statement.setInt(2, Integer.parseInt(quantityStr));
                statement.setDouble(3, Double.parseDouble(priceStr));
                statement.setInt(4, Integer.parseInt(availableStr));

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("./products.jsp");
                } else {
                    response.sendRedirect("./error.jsp?message=Failed+to+add+product");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("./error.jsp?message=An+error+occurred");
        }
    }
}
