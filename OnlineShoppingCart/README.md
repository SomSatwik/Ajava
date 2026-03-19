<div align="center">

<!-- ANIMATED HEADER -->
<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=200&section=header&text=🛒%20Online%20Shopping%20Cart&fontSize=50&fontColor=fff&animation=twinkling&fontAlignY=35&desc=A%20Full-Stack%20Java%20E-Commerce%20Web%20Application&descAlignY=60&descSize=18"/>

<br/>

<!-- BADGES -->
![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Hibernate](https://img.shields.io/badge/Hibernate-59666C?style=for-the-badge&logo=Hibernate&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![Maven](https://img.shields.io/badge/Apache%20Maven-C71A36?style=for-the-badge&logo=Apache%20Maven&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)

<br/>

![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat-square)
![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)
![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-ff69b4?style=flat-square)

<br/>

> **A fully functional e-commerce shopping cart built with Java EE — Browse products, manage your cart, checkout, and track orders. All powered by Hibernate ORM, Servlet-JSP architecture, and MySQL.**

<br/>

[🚀 Live Demo](#-demo) · [📖 Docs](#-project-structure) · [🐛 Report Bug](https://github.com/SomSatwik/Ajava/issues) · [✨ Request Feature](https://github.com/SomSatwik/Ajava/issues)

</div>

---

## 📸 Screenshots

<div align="center">

| Home Page | Product Listing |
|-----------|----------------|
| ![Home](https://via.placeholder.com/500x300/0d0d1a/7c3aed?text=🏠+Home+Page) | ![Products](https://via.placeholder.com/500x300/0d0d1a/06b6d4?text=🛍️+Products) |

| Shopping Cart | Admin Panel |
|--------------|-------------|
| ![Cart](https://via.placeholder.com/500x300/0d0d1a/10b981?text=🛒+Cart) | ![Admin](https://via.placeholder.com/500x300/0d0d1a/f43f5e?text=⚙️+Admin) |

</div>

---

## ✨ Features

<div align="center">

| 🛍️ Shopping | 👤 User | ⚙️ Admin |
|-------------|---------|----------|
| Browse products by category | Register & Login | Add / Edit / Delete products |
| Add to cart & update quantity | View order history | Manage all orders |
| Remove items from cart | Secure session management | View all customers |
| Checkout & place order | Profile management | Stock management |
| Real-time cart total | Logout securely | Sales dashboard |

</div>

---

## 🧰 Tech Stack

```
╔══════════════════════════════════════════════════════════╗
║                    TECH STACK                            ║
╠══════════════╦═══════════════════════════════════════════╣
║  Frontend    ║  JSP · HTML5 · CSS3 · JavaScript          ║
╠══════════════╬═══════════════════════════════════════════╣
║  Backend     ║  Java · Servlets · Hibernate ORM          ║
╠══════════════╬═══════════════════════════════════════════╣
║  Database    ║  MySQL 8.0                                 ║
╠══════════════╬═══════════════════════════════════════════╣
║  Server      ║  Apache Tomcat 10.x                        ║
╠══════════════╬═══════════════════════════════════════════╣
║  Build Tool  ║  Apache Maven                              ║
╠══════════════╬═══════════════════════════════════════════╣
║  ORM Config  ║  hibernate.cfg.xml · hbm2ddl.auto=update  ║
╚══════════════╩═══════════════════════════════════════════╝
```

---

## 🗄️ Database Schema

```sql
-- USERS TABLE
CREATE TABLE users (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(100)        NOT NULL,
  email       VARCHAR(100) UNIQUE NOT NULL,
  password    VARCHAR(100)        NOT NULL,
  role        ENUM('USER','ADMIN') DEFAULT 'USER',
  created_at  TIMESTAMP           DEFAULT CURRENT_TIMESTAMP
);

-- PRODUCTS TABLE
CREATE TABLE products (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(150)    NOT NULL,
  description TEXT,
  price       DECIMAL(10,2)   NOT NULL,
  stock       INT             DEFAULT 0,
  category    VARCHAR(100),
  image_url   VARCHAR(255)
);

-- ORDERS TABLE
CREATE TABLE orders (
  orderId     INT AUTO_INCREMENT PRIMARY KEY,
  userId      INT           NOT NULL,
  totalAmount DECIMAL(10,2) NOT NULL,
  status      ENUM('PLACED','PROCESSING','SHIPPED','DELIVERED') DEFAULT 'PLACED',
  orderedAt   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES users(id)
);

-- ORDER ITEMS TABLE
CREATE TABLE order_items (
  itemId      INT AUTO_INCREMENT PRIMARY KEY,
  orderId     INT           NOT NULL,
  productId   INT           NOT NULL,
  quantity    INT           NOT NULL,
  price       DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (orderId)    REFERENCES orders(orderId),
  FOREIGN KEY (productId)  REFERENCES products(id)
);

-- CART TABLE
CREATE TABLE cart (
  cartId      INT AUTO_INCREMENT PRIMARY KEY,
  userId      INT NOT NULL,
  productId   INT NOT NULL,
  quantity    INT DEFAULT 1,
  FOREIGN KEY (userId)    REFERENCES users(id),
  FOREIGN KEY (productId) REFERENCES products(id)
);
```

---

## 📁 Project Structure

```
OnlineShoppingCart/
│
├── 📄 pom.xml
│
├── src/
│   └── main/
│       ├── java/
│       │   ├── 📦 model/
│       │   │   ├── User.java
│       │   │   ├── Product.java
│       │   │   ├── Order.java
│       │   │   ├── OrderItem.java
│       │   │   └── Cart.java
│       │   │
│       │   ├── 📦 dao/
│       │   │   ├── UserDao.java
│       │   │   ├── ProductDao.java
│       │   │   ├── CartDao.java
│       │   │   └── OrderDao.java
│       │   │
│       │   ├── 📦 servlet/
│       │   │   ├── LoginServlet.java
│       │   │   ├── RegisterServlet.java
│       │   │   ├── ProductServlet.java
│       │   │   ├── CartServlet.java
│       │   │   ├── CheckoutServlet.java
│       │   │   ├── OrderServlet.java
│       │   │   └── AdminServlet.java
│       │   │
│       │   └── 📦 util/
│       │       └── HibernateUtil.java
│       │
│       └── webapp/
│           ├── 📂 css/
│           │   └── style.css
│           ├── 📂 js/
│           │   └── main.js
│           ├── 📂 images/
│           ├── index.jsp
│           ├── login.jsp
│           ├── register.jsp
│           ├── products.jsp
│           ├── cart.jsp
│           ├── checkout.jsp
│           ├── orderSuccess.jsp
│           ├── orderHistory.jsp
│           ├── adminPanel.jsp
│           └── WEB-INF/
│               ├── web.xml
│               └── hibernate.cfg.xml
│
└── target/
    └── OnlineShoppingCart.war
```

---

## ⚡ Getting Started

### Prerequisites

Make sure you have these installed:

```bash
✅ Java JDK 11 or higher
✅ Apache Maven 3.8+
✅ MySQL 8.0+
✅ Apache Tomcat 10.x
✅ Any IDE (IntelliJ IDEA recommended)
```

### 🔧 Installation

**1. Clone the repository**
```bash
git clone https://github.com/SomSatwik/Ajava.git
cd Ajava/OnlineShoppingCart
```

**2. Create MySQL database**
```sql
CREATE DATABASE online_shopping_db;
USE online_shopping_db;
-- Run the SQL from Database Schema section above
```

**3. Configure Hibernate**

Edit `src/main/webapp/WEB-INF/hibernate.cfg.xml`:
```xml
<property name="connection.url">
  jdbc:mysql://localhost:3306/online_shopping_db?useSSL=false&serverTimezone=UTC
</property>
<property name="connection.username">root</property>
<property name="connection.password">YOUR_PASSWORD</property>
```

**4. Build the project**
```bash
mvn clean package
```

**5. Deploy to Tomcat**
```bash
# Stop Tomcat
shutdown.bat   # Windows
./shutdown.sh  # Mac/Linux

# Copy WAR to webapps
cp target/OnlineShoppingCart.war /path/to/tomcat/webapps/

# Start Tomcat
startup.bat    # Windows
./startup.sh   # Mac/Linux
```

**6. Open in browser**
```
http://localhost:8080/OnlineShoppingCart/
```

---

## 🔑 Default Credentials

```
👤 Admin Login
   Email:    admin@shop.com
   Password: admin123

👤 Test User
   Email:    user@shop.com
   Password: user123
```

---

## 🌐 API / URL Routes

| Method | URL | Servlet | Description |
|--------|-----|---------|-------------|
| GET/POST | `/login` | `LoginServlet` | User login |
| GET/POST | `/register` | `RegisterServlet` | New user registration |
| GET | `/products` | `ProductServlet` | View all products |
| POST | `/cart/add` | `CartServlet` | Add item to cart |
| POST | `/cart/remove` | `CartServlet` | Remove item from cart |
| GET | `/cart` | `CartServlet` | View cart |
| POST | `/checkout` | `CheckoutServlet` | Place order |
| GET | `/orders` | `OrderServlet` | View order history |
| GET | `/admin` | `AdminServlet` | Admin dashboard |
| GET | `/logout` | `LogoutServlet` | Logout |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                      BROWSER                            │
│                   JSP + HTML/CSS/JS                     │
└──────────────────────────┬──────────────────────────────┘
                           │ HTTP Request
┌──────────────────────────▼──────────────────────────────┐
│                  APACHE TOMCAT SERVER                    │
│  ┌────────────────────────────────────────────────────┐ │
│  │                    SERVLETS                        │ │
│  │  Login │ Register │ Cart │ Checkout │ Admin        │ │
│  └──────────────────────┬─────────────────────────────┘ │
│                         │                               │
│  ┌──────────────────────▼─────────────────────────────┐ │
│  │                  DAO LAYER                         │ │
│  │  UserDao │ ProductDao │ CartDao │ OrderDao          │ │
│  └──────────────────────┬─────────────────────────────┘ │
│                         │                               │
│  ┌──────────────────────▼─────────────────────────────┐ │
│  │            HIBERNATE ORM (SessionFactory)          │ │
│  └──────────────────────┬─────────────────────────────┘ │
└─────────────────────────┼───────────────────────────────┘
                          │ JDBC
┌─────────────────────────▼───────────────────────────────┐
│                    MYSQL DATABASE                        │
│     users │ products │ cart │ orders │ order_items       │
└─────────────────────────────────────────────────────────┘
```

---

## 🤝 Contributing

Contributions are always welcome!

```bash
# 1. Fork the project
# 2. Create your feature branch
git checkout -b feature/AmazingFeature

# 3. Commit your changes
git commit -m 'Add some AmazingFeature'

# 4. Push to the branch
git push origin feature/AmazingFeature

# 5. Open a Pull Request
```

---

## 👨‍💻 Author

<div align="center">

**Som Satwik**

[![GitHub](https://img.shields.io/badge/GitHub-SomSatwik-181717?style=for-the-badge&logo=github)](https://github.com/SomSatwik)

</div>

---

## 📄 License

```
MIT License — feel free to use this project for learning and development.
```

---

<div align="center">

<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=100&section=footer"/>

**⭐ Star this repo if you found it helpful!**

*Built with ❤️ using Java + Hibernate + JSP*

</div>
