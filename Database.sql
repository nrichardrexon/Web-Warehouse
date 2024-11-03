CREATE DATABASE warehouse;

USE warehouse;

-- Table for employees
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(50)
);

-- Table for products
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2),
    availableStock INT
);

-- Sample Employees
INSERT INTO employees (username, password) VALUES ('admin', 'admin123');

-- Sample Products
INSERT INTO product (productName, quantity, price, availableStock) VALUES
('Product A', 200, 25.00, 150),
('Product B', 100, 50.00, 75);
