<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <style>
        table {
            width: 60%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
        }

        table, th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">Stock Product Management</h1>

    <table>
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Total Product</th>
                <th>Price</th>
                <th>Available Product</th>
            </tr>
        </thead>
        <tbody>
            <%  
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbUrl = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12741091"; // Adjust your DB URL
                String dbUsername = "sql12741091"; // Your DB username
                String dbPassword = "krzpU6TWyN"; // Your DB password

                connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                String sql = "SELECT * FROM product";
                preparedStatement = connection.prepareStatement(sql);
                resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    String productName = resultSet.getString("productName");
                    int quantity = resultSet.getInt("quantity");
                    double price = resultSet.getDouble("price");
                    int availableStock = resultSet.getInt("availableStock");
            %>
            <tr>
                <td><%= productName %></td>
                <td><%= quantity %></td>
                <td><%= String.format("%.2f", price) %></td>
                <td><%= availableStock %></td>
            </tr>
            <% 
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error retrieving products. Please try again later.</td></tr>");
                e.printStackTrace();
            } finally {
                try { if (resultSet != null) resultSet.close(); } catch (Exception e) { }
                try { if (preparedStatement != null) preparedStatement.close(); } catch (Exception e) { }
                try { if (connection != null) connection.close(); } catch (Exception e) { }
            }
            %>
        </tbody>
    </table>
</body>
</html>
