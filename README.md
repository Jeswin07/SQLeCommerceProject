
# E-Commerce Order Management Database (PostgreSQL)

This project contains a complete SQL-based e-commerce order management system designed and implemented using PostgreSQL. It demonstrates database design, ER modeling, CRUD operations, joins, analytical queries, transactions, functions, procedures, and triggers.
All project details are documented in the included PDF. 


## 1. Project Overview

This database system simulates real-world e-commerce workflows such as managing customers, products, orders, payments, and stock.

Key concepts demonstrated:
* Database design and normalization
* Entity–relationship modeling
* DDL and DML operations
* Joins and subqueries
* Aggregate and analytical queries
* Indexing for performance
* Views
* Stored functions and procedures
* Transactions
* Triggers for automated operations


## 2. Repository Structure

```
SQL-Ecommerce-Project/
│
├── README.md
├── SQLProjectDocumentation.pdf
├── er_diagram.png
└── ecommerce.sql
```

* **SQLProjectDocumentation.pdf** – Full project report with schema, diagrams, and sample outputs
* **er_diagram.png** – ER diagram
* **ecommerce.sql** – Schema, inserts, queries, functions, procedures, and triggers


## 3. Database Design Summary

Main entities (Pages 3–4 of PDF): 

* Customers
* Products
* Orders
* Order_Items
* Payments

Relationships:

* Customers → Orders (1-to-many)
* Orders → Order_Items (1-to-many)
* Orders → Payments (1-to-1)
* Customers ↔ Products via Order_Items (many-to-many)

The ER diagram provides a full structure overview.


## 4. Features Included in the Project

### 4.1 Schema and Sample Data

Includes:

* 30 customers
* 20 products
* 80 orders
* 200 order_items
* 80 payments

Sample datasets are shown on Pages 6–8. 

### 4.2 SQL Operations

* CRUD operations
* Filtering, sorting
* Various join types
* Subqueries and nested queries

### 4.3 Analytical Queries

Examples include:

* Category-wise revenue
* Customer spending analysis
* Product price analytics

### 4.4 Views

Example: `high_value_orders` view.

### 4.5 Stored Procedures and Functions

Includes procedures/functions for:

* Restocking products
* Calculating total order amount
* Calculating customer spending
* Calculating revenue by product

(Referenced on Pages 16–18.) 

### 4.6 Transactions

Demonstrates safe update patterns and rollback mechanisms.

### 4.7 Triggers

* Reduces stock when an order item is inserted
* Prevents negative stock levels

(Shown on Page 18–19.) 

---

## 5. How to Run the Project

### Step 1: Clone the repository

```sh
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

### Step 2: Open PostgreSQL (pgAdmin or psql)

### Step 3: Run the SQL script

```sql
\i ecommerce.sql;
```

This will create tables, insert sample data, create views, indexes, functions, and triggers.


## 6. Use Cases

This project can be used for:

* SQL practice
* Portfolio demonstration
* Academic submissions
* Understanding e-commerce database logic
* Backend/data engineering learning


## 7. Author

**Jeswin K Reji**
Aspiring Data Scientist
[jeswinkr7@gmail.com](mailto:jeswinkr7@gmail.com)

