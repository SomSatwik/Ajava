<div align="center">

```
██████╗ ██╗██████╗ ██╗     ██╗ ██████╗ ██╗  ██╗
██╔══██╗██║██╔══██╗██║     ██║██╔═══██╗╚██╗██╔╝
██████╔╝██║██████╔╝██║     ██║██║   ██║ ╚███╔╝ 
██╔══██╗██║██╔══██╗██║     ██║██║   ██║ ██╔██╗ 
██████╔╝██║██████╔╝███████╗██║╚██████╔╝██╔╝ ██╗
╚═════╝ ╚═╝╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝
```

### *A cinematic Library Management System built with Java, Hibernate & pure Servlet architecture.*

<br/>

![Java](https://img.shields.io/badge/Java-24-orange?style=for-the-badge&logo=openjdk&logoColor=white)
![Hibernate](https://img.shields.io/badge/Hibernate-6.4-59666C?style=for-the-badge&logo=hibernate&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-10.1-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![Maven](https://img.shields.io/badge/Maven-3.x-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)

<br/>

> *"Redefining how libraries are managed — dark, fast, and brutally clean."*

<br/>

</div>

---

## ⚡ What is BiblioX?

**BiblioX** is a full-stack Library Management System built from scratch using **Java Servlets**, **Hibernate ORM**, and a cinematic dark UI inspired by [landonorris.com](https://landonorris.com). No Spring Boot. No shortcuts. Pure Java, raw Hibernate SessionFactory, and handcrafted HTML/CSS that actually slaps.

Built as part of a **2nd year CSE project** at GIET University — but engineered like it's production-ready.

---

## 🎯 Features

### 🔐 Role-Based Access Control
| Role | Access |
|------|--------|
| `SUPER_ADMIN` | Full access — manage everything, change roles, delete books |
| `ADMIN` | Manage students, issue/return books, view catalogue |
| `USER` | Browse books, view their 1 issued book + due date |

### 📚 Book Management
- Full catalogue with search by title, author, genre
- Add / delete books (admin only)
- Real-time availability tracking
- Auto-colored book spines based on title hash

### 👥 Member Management
- View all registered members
- Role promotion/demotion (Super Admin only)
- Member borrow history

### ↕ Issue & Return System
- Issue 1 book per user at a time — strictly enforced
- Auto due date = issue date + 14 days
- Return processing with availability update
- Overdue detection with visual indicators

### 🎨 Cinematic UI
- Jet black dark theme with `#C8FF00` lime accent
- Bebas Neue display font + JetBrains Mono for data
- Slide-in panels, count-up animations, glow effects
- Inspired by Formula 1 editorial design

---

## 🏗 Tech Stack

```
┌─────────────────────────────────────────┐
│  FRONTEND                               │
│  HTML5 + CSS3 (custom design system)   │
│  Vanilla JS (no frameworks)            │
│  Google Fonts CDN                      │
├─────────────────────────────────────────┤
│  BACKEND                                │
│  Java 24                               │
│  Jakarta Servlets 6.0                  │
│  Hibernate ORM 6.4 (SessionFactory)    │
│  BCrypt password hashing               │
├─────────────────────────────────────────┤
│  DATABASE                               │
│  MySQL 8.0                             │
│  Auto schema generation (hbm2ddl)      │
├─────────────────────────────────────────┤
│  DEPLOYMENT                             │
│  Apache Tomcat 10.1                    │
│  Maven WAR packaging                   │
└─────────────────────────────────────────┘
```

---

## 🗂 Project Structure

```
bibliox/
├── src/main/java/com/bibliox/
│   ├── model/              # Hibernate @Entity classes
│   │   ├── User.java
│   │   ├── Book.java
│   │   ├── IssuedBook.java
│   │   ├── Role.java       (enum: SUPER_ADMIN, ADMIN, USER)
│   │   └── IssueStatus.java (enum: ISSUED, RETURNED, OVERDUE)
│   ├── dao/                # Data Access Layer (SessionFactory)
│   │   ├── UserDAO.java
│   │   ├── BookDAO.java
│   │   └── IssuedBookDAO.java
│   ├── servlet/            # HTTP request handlers
│   │   ├── LoginServlet.java
│   │   ├── DashboardServlet.java
│   │   ├── BookServlet.java
│   │   ├── MemberServlet.java
│   │   ├── IssueServlet.java
│   │   └── MyBooksServlet.java
│   ├── filter/
│   │   └── AuthFilter.java # Session-based auth guard
│   └── util/
│       ├── HibernateUtil.java    # SessionFactory singleton
│       ├── PasswordUtil.java     # BCrypt wrapper
│       ├── DataSeeder.java       # Default data on startup
│       └── AppContextListener.java
├── src/main/webapp/
│   ├── css/style.css       # Full custom design system
│   ├── js/main.js          # Animations + interactions
│   ├── pages/              # JSP pages
│   │   ├── login.jsp
│   │   ├── dashboard.jsp
│   │   ├── books.jsp
│   │   ├── members.jsp
│   │   ├── issue.jsp
│   │   └── my-books.jsp
│   └── WEB-INF/web.xml
├── src/main/resources/
│   └── hibernate.cfg.xml
└── pom.xml
```

---

## 🚀 Getting Started

### Prerequisites
- Java 17+
- MySQL 8.0
- Apache Tomcat 10.1
- Maven 3.x
- IntelliJ IDEA (recommended)

### 1. Clone the repo
```bash
git clone https://github.com/SomSatwik/Ajava.git
cd Ajava/bibliox
```

### 2. Create the database
```sql
CREATE DATABASE IF NOT EXISTS bibliox;
```
> Hibernate auto-creates all tables on first run via `hbm2ddl.auto=update`

### 3. Configure database credentials
Edit `src/main/resources/hibernate.cfg.xml`:
```xml
<property name="hibernate.connection.username">your_username</property>
<property name="hibernate.connection.password">your_password</property>
```

### 4. Build with Maven
```bash
mvn clean install
```

### 5. Deploy to Tomcat
- Open IntelliJ → Run/Debug Configurations
- Add Smart Tomcat config pointing to this project
- Hit **Run** 🟢

### 6. Open in browser
```
http://localhost:8080/Library/login
```

---

## 🔑 Default Credentials

| Role | Email | Password |
|------|-------|----------|
| Super Admin | `superadmin@bibliox.com` | `admin123` |
| Admin | `admin@bibliox.com` | `admin123` |
| Student | `student@bibliox.com` | `student123` |

> Seeded automatically on first startup via `DataSeeder.java`

---

## 📐 Database Schema

```
users
├── id (PK, AUTO_INCREMENT)
├── name
├── email (UNIQUE)
├── password (BCrypt)
├── role (SUPER_ADMIN | ADMIN | USER)
└── created_at

books
├── id (PK, AUTO_INCREMENT)
├── title
├── author
├── isbn (UNIQUE)
├── genre
├── total_copies
├── available_copies
└── added_at

issued_books
├── id (PK, AUTO_INCREMENT)
├── user_id (FK → users)
├── book_id (FK → books)
├── issued_date
├── due_date (issued_date + 14 days)
├── return_date (nullable)
└── status (ISSUED | RETURNED | OVERDUE)
```

---

## 🎨 Design System

```css
--bg:       #080810   /* Jet black background    */
--accent:   #C8FF00   /* Lime green — main punch */
--danger:   #FF2F5B   /* Red — overdue/errors    */
--success:  #00FFB3   /* Cyan — available/ok     */
--warn:     #FFB300   /* Amber — due soon        */

--font-display: 'Bebas Neue'      /* Big headings     */
--font-body:    'DM Sans'         /* Body text        */
--font-mono:    'JetBrains Mono'  /* Labels/data/code */
```

---

## 🛣 Routes

| Method | Route | Access | Description |
|--------|-------|--------|-------------|
| GET | `/login` | Public | Login page |
| POST | `/login` | Public | Authenticate |
| GET | `/logout` | Auth | Invalidate session |
| GET | `/dashboard` | Admin+ | Stats overview |
| GET | `/books` | All | Book catalogue |
| POST | `/books` | Admin+ | Add/delete book |
| GET | `/members` | Admin+ | Member list |
| POST | `/members` | Super Admin | Change role |
| GET | `/issue` | Admin+ | Issue/return page |
| POST | `/issue` | Admin+ | Process issue/return |
| GET | `/my-books` | User | Student's books |

---

## 👨‍💻 Author

**Som Satwik Deo**
2nd Year CSE · GIET University

[![GitHub](https://img.shields.io/badge/GitHub-SomSatwik-181717?style=for-the-badge&logo=github)](https://github.com/SomSatwik)
[![Twitter](https://img.shields.io/badge/Twitter-real__som7-1DA1F2?style=for-the-badge&logo=twitter)](https://twitter.com/real_som7)
[![Instagram](https://img.shields.io/badge/Instagram-som.7wik-E4405F?style=for-the-badge&logo=instagram)](https://instagram.com/som.7wik)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

<div align="center">

*Built with zero frameworks and maximum effort.*

**⭐ Star this repo if it helped you!**

</div>
