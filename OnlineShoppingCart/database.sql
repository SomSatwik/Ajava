CREATE DATABASE IF NOT EXISTS shopping_cart_db;
USE shopping_cart_db;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  phone VARCHAR(15),
  address TEXT,
  role ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  icon VARCHAR(50)
);

CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  originalPrice DECIMAL(10,2),
  stock INT DEFAULT 0,
  imageUrl VARCHAR(500),
  categoryId INT,
  rating DECIMAL(3,2) DEFAULT 0,
  reviewCount INT DEFAULT 0,
  badge VARCHAR(50),
  featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (categoryId) REFERENCES categories(id)
);

CREATE TABLE cart_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  productId INT NOT NULL,
  quantity INT DEFAULT 1,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES users(id),
  FOREIGN KEY (productId) REFERENCES products(id)
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  totalAmount DECIMAL(10,2) NOT NULL,
  status ENUM('PENDING','CONFIRMED','SHIPPED','DELIVERED','CANCELLED') DEFAULT 'PENDING',
  shippingAddress TEXT NOT NULL,
  paymentMethod VARCHAR(50),
  orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES users(id)
);

CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  orderId INT NOT NULL,
  productId INT NOT NULL,
  quantity INT NOT NULL,
  priceAtTime DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (orderId) REFERENCES orders(id),
  FOREIGN KEY (productId) REFERENCES products(id)
);

CREATE TABLE wishlist (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  productId INT NOT NULL,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES users(id),
  FOREIGN KEY (productId) REFERENCES products(id)
);

-- Sample data
INSERT INTO categories VALUES
(1,'Electronics','Gadgets and devices','⚡'),
(2,'Fashion','Clothing and accessories','👗'),
(3,'Home & Living','Furniture and decor','🏠'),
(4,'Sports','Equipment and gear','⚽'),
(5,'Books','All genres','📚');

INSERT INTO users (name,email,password,role)
VALUES ('Admin','admin@shop.com','admin123','ADMIN');

INSERT INTO products (name,description,price,originalPrice,stock,imageUrl,categoryId,rating,reviewCount,badge,featured)
VALUES
('iPhone 15 Pro Case','Luxury leather case',4499.00,4999.00,50,'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',1,4.8,2341,'NEW',TRUE),
('Sony Headphones','Premium audio',3999.00,4599.00,100,'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=400',1,4.9,5621,'BESTSELLER',TRUE),
('Nike Shoes','Running footwear',3499.00,4299.00,200,'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',4,4.7,1823,'SALE',FALSE),
('Keyboard Case','For 14-inch laptops',2499.00,2999.00,30,'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',1,4.9,987,'HOT',TRUE),
('Leather Jacket','Sleek black finish',4999.00,5999.00,75,'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400',2,4.5,432,'SALE',FALSE),
('PS5 Controller','DualSense limited',4999.00,5499.00,150,'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400',1,4.8,3241,'',TRUE);
