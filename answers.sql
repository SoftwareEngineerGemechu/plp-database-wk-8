-- E-commerce Store database schema for MySQL

state VARCHAR(100),
postal_code VARCHAR(30),
country VARCHAR(100) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_addresses_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;


-- Orders (one-to-many: user -> orders)
CREATE TABLE orders (
order_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
status ENUM('pending','processing','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
shipping_address_id INT UNSIGNED,
billing_address_id INT UNSIGNED,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT,
CONSTRAINT fk_orders_shipping_addr FOREIGN KEY (shipping_address_id) REFERENCES addresses(address_id) ON DELETE SET NULL,
CONSTRAINT fk_orders_billing_addr FOREIGN KEY (billing_address_id) REFERENCES addresses(address_id) ON DELETE SET NULL
) ENGINE=InnoDB;


-- Order items (composite PK) — eliminates redundancy about product per order
CREATE TABLE order_items (
order_id BIGINT UNSIGNED NOT NULL,
product_id INT UNSIGNED NOT NULL,
quantity INT UNSIGNED NOT NULL DEFAULT 1,
unit_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
PRIMARY KEY (order_id, product_id),
CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
) ENGINE=InnoDB;


-- Payments (one-to-one or one-to-many depending on design; allow multiple payments per order)
CREATE TABLE payments (
payment_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
order_id BIGINT UNSIGNED NOT NULL,
payment_method ENUM('card','paypal','bank_transfer') NOT NULL,
amount DECIMAL(12,2) NOT NULL,
transaction_reference VARCHAR(255),
status ENUM('initiated','completed','failed','refunded') NOT NULL DEFAULT 'initiated',
processed_at TIMESTAMP NULL,
CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
) ENGINE=InnoDB;


-- Product reviews (user -> product)
CREATE TABLE reviews (
review_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
product_id INT UNSIGNED NOT NULL,
user_id INT UNSIGNED NOT NULL,
rating TINYINT UNSIGNED NOT NULL CHECK (rating >= 1 AND rating <= 5),
title VARCHAR(255),
body TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_reviews_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;


-- Useful indexes
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orderitems_product ON order_items(product_id);


-- Example: seed a few rows (optional)
-- INSERT INTO categories (name) VALUES ('Electronics'), ('Accessories');
-- INSERT INTO users (email, password_hash, first_name, last_name) VALUES ('alice@example.com', 'hash', 'Alice', 'Smith');


-- End of answers.sql