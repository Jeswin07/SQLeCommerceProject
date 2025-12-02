-- Table Creation
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(25),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
	
    FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id) 
        ON DELETE CASCADE
);

CREATE TABLE Order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    UNIQUE(order_id, product_id)
);

CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    payment_method VARCHAR(25),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2),

    FOREIGN KEY (order_id) 
        REFERENCES orders(order_id)
        ON DELETE CASCADE
);

--Indexes for faster queries
CREATE INDEX idx_orders_customer_id
ON Orders(customer_id);

CREATE INDEX idx_order_items_order_id 
ON order_items(order_id);

CREATE INDEX idx_order_items_product_id 
ON order_items(product_id);

CREATE INDEX idx_orders_order_date
ON orders(order_date);

CREATE INDEX idx_products_name
ON products(product_name);

-- Insertion of datas
INSERT INTO customers (customer_name, email, phone, city) VALUES
('Amit Sharma', 'amit@example.com', '9876543210', 'Delhi'),
('Sneha Nair', 'sneha@example.com', '9123456780', 'Kochi'),
('Ravi Kumar', 'ravi@example.com', '9988776655', 'Bangalore'),
('Priya Singh', 'priya@example.com', '9090909090', 'Mumbai'),
('John Mathew', 'john@example.com', '9876501234', 'Pune'),
('Rahul Das', 'rahul@example.com', '9811122233', 'Kolkata'),
('Sara Thomas', 'sara@example.com', '9800011112', 'Chennai'),
('David Joseph', 'david@example.com', '9900088887', 'Hyderabad'),
('Kevin George', 'kevin@example.com', '9812345678', 'Delhi'),
('Latha Krishnan', 'latha@example.com', '9900011122', 'Bangalore'),
('Sajid Ali', 'sajid@example.com', '9001122334', 'Chennai'),
('Nirmala Devi', 'nirmala@example.com', '9800001110', 'Pune'),
('Harish Menon', 'harish@example.com', '9822233344', 'Mumbai'),
('Anu Ramesh', 'anu@example.com', '9833344455', 'Kochi'),
('Joel Benny', 'joel@example.com', '9799911223', 'Hyderabad'),
('Mohan Lal', 'mohan@example.com', '9011223344', 'Kolkata'),
('Aswin K', 'aswin@example.com', '9003344556', 'Chennai'),
('Riya Paul', 'riya@example.com', '9445566778', 'Bangalore'),
('Aarav Sen', 'aarav@example.com', '9556677889', 'Delhi'),
('Disha Patil', 'disha@example.com', '9442211334', 'Mumbai'),
('Kiran Joseph', 'kiranj@example.com', '9455566778', 'Pune'),
('Vishal Roy', 'vishal@example.com', '9345566778', 'Kolkata'),
('Neeraj Kumar', 'neeraj@example.com', '9100099887', 'Chennai'),
('Meera S', 'meera@example.com', '9877701122', 'Kochi'),
('Sona Mathew', 'sona@example.com', '9922110044', 'Bangalore'),
('Ajay G', 'ajay@example.com', '9112233445', 'Mumbai'),
('Kavya S', 'kavya@example.com', '9009988776', 'Delhi'),
('Rohit P', 'rohitp@example.com', '9332211009', 'Hyderabad'),
('Shreya K', 'shreya@example.com', '9441234567', 'Pune'),
('Deepak R', 'deepak@example.com', '9551122334', 'Kolkata');

INSERT INTO products (product_name, category, price, stock) VALUES
('Legion 5 Laptop', 'Electronics', 95000, 20),
('iPhone 14', 'Electronics', 120000, 15),
('Samsung Monitor 27"', 'Electronics', 23000, 18),
('Wireless Mouse', 'Accessories', 1200, 80),
('Mechanical Keyboard', 'Accessories', 4500, 50),
('Boat Headphones', 'Accessories', 1800, 60),
('Logitech Webcam', 'Electronics', 5000, 25),
('Gaming Chair', 'Furniture', 15000, 10),
('Office Desk', 'Furniture', 20000, 12),
('Water Bottle', 'Home', 300, 150),
('Notebook Set', 'Stationery', 150, 200),
('Ball Pen Pack', 'Stationery', 120, 300),
('Standing Desk', 'Furniture', 18000, 15),
('Projector X2', 'Electronics', 35000, 8),
('Bluetooth Speaker', 'Accessories', 2500, 70),
('Smartwatch FitPro', 'Electronics', 8000, 30),
('USB-C Cable', 'Accessories', 350, 200),
('Portable SSD 1TB', 'Electronics', 9000, 25),
('Laptop Stand', 'Accessories', 1500, 40),
('Desk Lamp', 'Home', 850, 60);

INSERT INTO orders (customer_id, total_amount)
SELECT (floor(random() * 30) + 1)::int,
       (random() * 120000 + 500)::numeric(10,2)
FROM generate_series(1,80);

INSERT INTO order_items (order_id, product_id, quantity, price)
SELECT 
    (floor(random() * 80) + 1)::int,
    (floor(random() * 20) + 1)::int,
    (floor(random() * 5) + 1)::int,
    (random() * 100000 + 100)::numeric(10,2)
FROM generate_series(1,200);

WITH RECURSIVE items AS (
    SELECT
        (floor(random() * 80) + 1)::int AS order_id,
        (floor(random() * 20) + 1)::int AS product_id
    UNION ALL
    SELECT
        (floor(random() * 80) + 1)::int AS order_id,
        (floor(random() * 20) + 1)::int AS product_id
    FROM generate_series(1,500)
)
INSERT INTO order_items(order_id, product_id, quantity, price)
SELECT DISTINCT ON (order_id, product_id)
    order_id,
    product_id,
    (floor(random() * 5) + 1)::int,
    (random() * 50000 + 200)::numeric(10,2)
FROM items
LIMIT 200;

INSERT INTO payments (order_id, payment_method, amount_paid)
SELECT 
    order_id,
    (ARRAY['UPI','Credit Card','Debit Card','Cash','Net Banking'])[floor(random()*5)+1],
    total_amount
FROM orders;

SELECT * FROM Customers LIMIT 10;
SELECT * FROM Products LIMIT 10;
SELECT * FROM Orders LIMIT 10;
SELECT * FROM Order_items LIMIT 10;
SELECT * FROM Payments LIMIT 10;

--SELECT queries
SELECT * FROM Customers WHERE city = 'Kochi';
SELECT * FROM Products WHERE price > 10000 ORDER BY price DESC;
SELECT * FROM Customers WHERE customer_name ILIKE 'A%';
SELECT DISTINCT city FROM customers;
SELECT * FROM Products WHERE stock IS NOT NULL LIMIT 5;

--JOIN operations
--LEFT JOIN: Display Customers and Their Orders
SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.order_id
ORDER BY total_amount DESC LIMIT 10;

--INNER JOIN: Display Order Items With Product Details
SELECT oi.order_id, p.product_name, oi.quantity 
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY quantity DESC LIMIT 10;

--FULL JOIN: Display All Customers + All Orders
SELECT c.customer_name, o.order_id, o.total_amount
FROM Customers c
FULL JOIN orders o ON c.customer_id = o.customer_id LIMIT 10;

-- Product Category wise Sales
SELECT p.category, SUM(oi.quantity * oi.price ) AS total_sales
FROM Products p JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category ORDER BY total_sales DESC;

-- Top 5 customers by spending
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM Customers c JOIN Orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_name ORDER BY total_spent DESC LIMIT 5;

--Aggregate functions
--Count products by category
SELECT category, COUNT(*) AS total_products
FROM products GROUP BY category;

--Category with avg price above 10000
SELECT category, AVG(price) FROM products 
GROUP BY category HAVING AVG(price) > 10000;

--Total revenue from all sales
SELECT SUM(price * quantity) AS Total_revenue
FROM order_items;

--Cheapest and costliest products
SELECT MIN(price) AS cheapest, MAX(price) AS most_expensive
FROM products;

--Orders per city
SELECT c.city, COUNT(o.order_id) AS total_orders
FROM Customers c LEFT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.city ORDER BY total_orders DESC;

--Subqueries 
--Products above Average price
SELECT * FROM Products WHERE price > (SELECT AVG(price) FROM Products);

--Customers who never ordered
SELECT * FROM Customers 
WHERE customer_id NOT IN (SELECT customer_id FROM Orders);

--Product with avg price comparison
SELECT product_name, price, (SELECT AVG(price) FROM Products) AS avg_price
FROM Products;

-- 10% Discount to all those who spent more than 50000
UPDATE Orders SET total_amount = total_amount * 0.90
WHERE customer_id IN (SELECT customer_id FROM Orders
						GROUP BY customer_id HAVING SUM(total_amount) > 50000);

--Advanced Joins
--CROSS JOIN: each product with each Category
SELECT p.product_name, c.category FROM products p
CROSS JOIN (SELECT DISTINCT category FROM products) c;

--UNION ALL: Categorise with "High" and "Low" with total_amount as 50000
SELECT order_id, customer_id, total_amount, 'High' AS Spend
FROM Orders WHERE total_amount > 50000
UNION ALL
SELECT order_id, customer_id,total_amount, 'Low' AS Spend 
FROM Orders WHERE total_amount < 50000 
ORDER BY order_id;

--Views
-- High value orders
CREATE VIEW high_value_orders AS
SELECT order_id, customer_id, total_amount FROM Orders
WHERE total_amount > 50000 ORDER BY total_amount DESC;

SELECT * FROM high_value_orders LIMIT 5;

--Transactions
--Safe order placement
BEGIN;
UPDATE products SET stock = stock - 2 WHERE product_id = 12;
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES (1, CURRENT_DATE, 5000);
SELECT * FROM products WHERE product_id = 12;
--no issues, stock not negative. Hence Commit
COMMIT; 

--Stored Procedure to update stock
CREATE OR REPLACE PROCEDURE restock_product2 (p_product_id INT, p_quantity INT)
AS $$
BEGIN
	UPDATE products SET stock = stock + p_quantity
	WHERE product_id = p_product_id;
	COMMIT;
END;
$$ LANGUAGE plpgsql
SELECT * FROM products WHERE product_id = 8;
CALL restock_product2(8,10);
SELECT * FROM products WHERE product_id = 8;

--Function to get total order price
CREATE OR REPLACE FUNCTION get_order_total(p_order_id INT)
RETURNS INT AS $$
DECLARE 
	total_amt INT;
BEGIN
	SELECT SUM(quantity * price) INTO total_amt 
	FROM order_items WHERE order_id = p_order_id;
	RETURN total_amt;
END;
$$ LANGUAGE plpgsql

SELECT get_order_total(15);

--Function to get customer total spending
CREATE OR REPLACE FUNCTION customer_total_spent(p_customer_id INT)
RETURNS INT AS $$
DECLARE
	total_amt INT;
BEGIN
	SELECT SUM(total_amount) INTO total_amt
	FROM Orders WHERE customer_id = p_customer_id;
	RETURN total_amt;
END;
$$ LANGUAGE plpgsql

SELECT customer_total_spent(25);

--Function to check the total revenue by a product
CREATE OR REPLACE FUNCTION total_by_product(p_product_name VARCHAR(50))
RETURNS INT AS $$
DECLARE 
	total_amt INT;
BEGIN
	SELECT SUM(o.quantity * o.price) INTO total_amt
	FROM order_items o JOIN Products p ON p.product_id = o.product_id
	WHERE p.product_name ILIKE P_product_name;
	RETURN total_amt;
END;
$$ LANGUAGE plpgsql

SELECT total_by_product('Gaming Chair');

--Trigger to reduce stock when an item is ordered
CREATE OR REPLACE FUNCTION reduce_stock()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE Products SET stock = stock - NEW.quantity
	WHERE product_id = NEW.product_id;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON Order_items
FOR EACH ROW
EXECUTE FUNCTION reduce_stock();

SELECT * FROM Products WHERE Product_id = 7;
INSERT INTO Order_items (order_id, product_id, quantity, price)
VALUES (25,7,10,5000);
SELECT * FROM Products WHERE Product_id = 7;

--Trigger to prevent negative stock
CREATE OR REPLACE FUNCTION prevent_neg_stock()
RETURNS TRIGGER AS $$
DECLARE 
	stock_bal INT;
BEGIN
	SELECT stock INTO stock_bal FROM products
	WHERE product_id = NEW.product_id;

	IF stock_bal < NEW.quantity THEN
		RAISE EXCEPTION 'Insufficient Stock';
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_neg_stk
BEFORE INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION prevent_neg_stock();

SELECT * FROM ordeR_items;
INSERT INTO order_items(order_id, product_id,quantity,price) 
VALUES (40,5,100,2000);