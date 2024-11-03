<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Product Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }
        h1 {
            color: #007bff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <h1>Manage Products</h1>
    <table>
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver class for MySQL Connector/J
                    Connection conn = DriverManager.getConnection("jdbc:mysql://HOST/DB", "USER", "PASSWORD");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM products");

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("productName") + "</td>");
                        out.println("<td>" + rs.getString("category") + "</td>");
                        out.println("<td>$" + rs.getDouble("price") + "</td>");
                        out.println("<td><a href='editProduct.jsp?id=" + rs.getInt("id") + "'>Edit</a></td>");
                        out.println("</tr>");
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Failed to load products. Please contact support.</td></tr>");
                    e.printStackTrace(); // Optional: log error details to server logs
                }
            %>
        </tbody>
    </table>
</body>

</html>
