# E-commerce Store — Database Schema


## Overview
This project contains a MySQL relational schema for a simple E-commerce Store. The schema demonstrates:


- Well-structured tables with appropriate data types.
- Proper constraints: PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL.
- Relationships: One-to-Many (users -> orders), Many-to-Many (products <-> tags), One-to-Many (products -> images), etc.


## Included files
- `answers.sql` — SQL file with `CREATE DATABASE` and `CREATE TABLE` statements plus constraints and useful indexes.


## Entities and relationships (summary)
- `users` — customers of the store.
- `addresses` — shipping / billing addresses owned by users.
- `categories` — hierarchical product categories (self-referencing parent).
- `products` — items sold in the store (belongs to a category).
- `product_images` — images per product.
- `tags` and `product_tags` — many-to-many tags for products.
- `orders` — placed by users, references addresses for shipping/billing.
- `order_items` — line items for orders (composite PK on order_id + product_id).
- `payments` — payments related to orders.
- `reviews` — user reviews for products.


## Normalization & Design decisions
- The schema is normalized to at least 3NF for the core entities:
- Repeating/multi-valued attributes are separated into dedicated tables (e.g., product_images, product_tags).
- Partial dependencies are removed (e.g., separating users and orders).
- Transitive dependencies are minimized.


## How to use
1. Open a MySQL client (MySQL Workbench, CLI, etc.).
2. Run the `answers.sql` file: `source /path/to/answers.sql` or paste the contents into the client and execute.
3. (Optional) Seed sample data to test queries and operations.


## Assumptions
- MySQL 5.7+ / 8.0+ is available.
- Payments are simplified and not integrated with any real gateway.
- Passwords are stored as `password_hash` — production systems should use secure hashing + salt and a proper auth system.


## Next steps / Enhancements
- Add audit tables (e.g., order_history) for tracking status changes.
- Add product variants (size/color) as a separate table if needed.
- Add more sophisticated inventory management, warehouses, or reserved stock handling.
- Add triggers or stored procedures to keep `orders.total_amount` in sync with `order_items`.


## Contact / Support
If you want modifications (different use-case, extra fields, sample data, or ERD diagram), reply with what you'd like changed.
