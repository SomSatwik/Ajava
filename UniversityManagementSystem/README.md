<div align="center">

```
██╗   ██╗███╗   ██╗██╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗
██║   ██║████╗  ██║██║    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝
██║   ██║██╔██╗ ██║██║    ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  
██║   ██║██║╚██╗██║██║    ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  
╚██████╔╝██║ ╚████║██║    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗
 ╚═════╝ ╚═╝  ╚═══╝╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
```

### *A clean, fast University Student Management System built with Java, Hibernate & Servlets.*

<br/>

![Java](https://img.shields.io/badge/Java-24-orange?style=for-the-badge&logo=openjdk&logoColor=white)
![Hibernate](https://img.shields.io/badge/Hibernate-6.x-59666C?style=for-the-badge&logo=hibernate&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-10.1-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![Maven](https://img.shields.io/badge/Maven-3.x-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)

<br/>

> *"Managing university data — clean architecture, zero boilerplate SQL."*

<br/>

</div>

---

## ⚡ What is UniManage?

**UniManage** is a full-stack University Management System built from scratch using **Java Servlets**, **Hibernate ORM**, and **JSP**. No Spring Boot magic — just raw Java, direct Hibernate SessionFactory, and clean MVC architecture.

Built as part of a **2nd year CSE project** at GIET University.

---

## 🎯 Features

- **Student Registration** — Add new students with full name, email, course and enrollment year
- **Student Directory** — View all registered students in a clean table
- **Hibernate ORM** — Zero SQL written manually, all DB operations via Hibernate SessionFactory
- **MVC Architecture** — Clean separation of Servlet (Controller), Entity (Model), JSP (View)
- **Auto Schema** — Database tables created automatically on first run

---

## 🏗 Tech Stack

```
┌─────────────────────────────────────────┐
│  FRONTEND                               │
│  JSP (JavaServer Pages)                │
│  HTML5 + CSS3                          │
├─────────────────────────────────────────┤
│  BACKEND                                │
│  Java 24                               │
│  Jakarta Servlets 6.0                  │
│  Hibernate ORM 6.x (SessionFactory)    │
├─────────────────────────────────────────┤
│  DATABASE                               │
│  MySQL 8.0                             │
│  Auto schema via hbm2ddl               │
├─────────────────────────────────────────┤
│  DEPLOYMENT                             │
│  Apache Tomcat 10.1                    │
│  Maven WAR packaging                   │
└─────────────────────────────────────────┘
```

---

## 🗂 Project Structure

```
UniversityManagementSystem/
├── src/main/java/com/unimanage/
│   ├── entity/
│   │   └── Student.java          # Hibernate @Entity
│   ├── dao/
│   │   └── StudentDAO.java       # DB operations via SessionFactory
│   ├── servlet/
│   │   └── StudentServlet.java   # HTTP request handler
│   └── util/
│       └── HibernateUtil.java    # SessionFactory singleton
├── src/main/webapp/
│   ├── students.jsp              # Student list view
│   ├── addStudent.jsp            # Add student form
│   └── WEB-INF/
│       └── web.xml
├── src/main/resources/
│   └── hibernate.cfg.xml         # DB config
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
cd Ajava/UniversityManagementSystem
```

### 2. Create the database
```sql
CREATE DATABASE IF NOT EXISTS unimanage;
```
> Hibernate auto-creates all tables on first run

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
- Add Smart Tomcat config
- Hit **Run** 🟢

### 6. Open in browser
```
http://localhost:8080/UniversityManagementSystem/students
```

---

## 📐 Database Schema

```
students
├── id            (PK, AUTO_INCREMENT)
├── full_name     (VARCHAR)
├── email         (VARCHAR, UNIQUE)
├── course        (VARCHAR)
└── enrollment_year (INT)
```

---

## 🛣 Routes

| Method | Route | Description |
|--------|-------|-------------|
| GET | `/students` | View all students |
| GET | `/students?action=new` | Show add student form |
| POST | `/students` | Save new student |

---

## 🔍 How Hibernate Works Here

```java
// No SQL needed — Hibernate handles everything
Student newStudent = new Student(fullName, email, course, enrollmentYear);
studentDAO.saveStudent(newStudent); // → INSERT INTO students... (auto)

List<Student> all = studentDAO.getAllStudents(); // → SELECT * FROM students (auto)
```

> SessionFactory is initialized once at startup via `HibernateUtil.java`
> and reused across all DAO operations — efficient and clean.

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

*Built with raw Java and zero shortcuts.*

**⭐ Star this repo if it helped you!**

</div>
