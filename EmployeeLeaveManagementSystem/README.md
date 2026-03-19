<div align="center">

<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=12,20,24&height=220&section=header&text=🏢%20LeaveOS&fontSize=60&fontColor=fff&animation=twinkling&fontAlignY=38&desc=Employee%20Leave%20Management%20System&descAlignY=62&descSize=20"/>

<br/>

<!-- TECH BADGES -->
![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Hibernate](https://img.shields.io/badge/Hibernate-59666C?style=for-the-badge&logo=Hibernate&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![Maven](https://img.shields.io/badge/Apache%20Maven-C71A36?style=for-the-badge&logo=Apache%20Maven&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

<br/>

<!-- STATUS BADGES -->
![Status](https://img.shields.io/badge/Status-Active-10b981?style=flat-square&labelColor=0c0c1e)
![Version](https://img.shields.io/badge/Version-1.0.0-7c3aed?style=flat-square&labelColor=0c0c1e)
![Java Version](https://img.shields.io/badge/Java-11+-f59e0b?style=flat-square&labelColor=0c0c1e)
![Hibernate](https://img.shields.io/badge/Hibernate-5.6.15-06b6d4?style=flat-square&labelColor=0c0c1e)
![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-f43f5e?style=flat-square&labelColor=0c0c1e)
![License](https://img.shields.io/badge/License-MIT-a78bfa?style=flat-square&labelColor=0c0c1e)

<br/>

> **A full-stack Employee Leave Management System built with Java EE. Employees apply for leave, managers approve or reject — all tracked in real time. Features a NASA mission control × luxury fintech inspired dark UI with glowing neon accents, glassmorphism panels, and smooth micro-animations.**

<br/>

[🚀 Get Started](#-getting-started) · [✨ Features](#-features) · [🎨 UI Design](#-ui-design) · [🗄️ Database](#️-database-schema) · [📁 Structure](#-project-structure) · [🐛 Report Bug](../../issues)

</div>

---

## ✨ Features

<div align="center">

| 👤 Employee | 🛡️ Admin | 🎨 UI/UX |
|-------------|----------|----------|
| Register & Login securely | View all leave requests | Custom animated cursor |
| Apply for leave with date + reason | Approve / Reject with one click | 3D card tilt on hover |
| Choose leave type (Annual/Sick/Emergency/Personal) | Filter by status, search by name | Magnetic button effect |
| View own leave history | Live employee count stats | Glassmorphism panels |
| See status (Pending/Approved/Rejected) | Export data to CSV | Glitch text animation |
| Live duration calculator | Admin-only sidebar links | Staggered fade-up animations |
| Secure session management | Date range filtering | Toast notifications |
| Logout securely | Confirm modal before action | Scroll progress bar |

</div>

---

## 🎨 UI Design

The UI is inspired by **NASA mission control × luxury fintech** — ultra dark, neon glowing, glassmorphism, cinematic.

```
Design Language
───────────────────────────────────────────────────────
  Background      #020209  →  Near black void
  Surface         #0c0c1e  →  Deep navy glass
  Accent Violet   #7c3aed  →  Primary glow color
  Accent Cyan     #06b6d4  →  Secondary highlights
  Accent Pink     #f43f5e  →  Danger / Rejected
  Accent Green    #10b981  →  Success / Approved
  Accent Amber    #f59e0b  →  Warning / Pending
───────────────────────────────────────────────────────
  Fonts           Syne (headings)  ·  DM Sans (body)
  Effects         Glassmorphism  ·  Glow orbs  ·  Grid
  Motion          Drift orbs  ·  Shimmer lines  ·  Tilt
───────────────────────────────────────────────────────
```

### 🌐 Pages Breakdown

| Page | Layout | Key UI Elements |
|------|--------|-----------------|
| `login.jsp` | Split screen (55/45) | Glitch art left panel · Rotating rings · Scanline sweep · Floating glass form |
| `register.jsp` | Split screen | Password strength meter bar · Custom role selector |
| `dashboard.jsp` | Sidebar + main | 4 stat cards · Timeline activity · Quick Apply widget · Donut chart |
| `applyLeave.jsp` | Sidebar + 2-col | Step indicator · Live duration calc · Pill leave type selector · Calendar |
| `viewLeaves.jsp` | Sidebar + table | Floating row cards · Status badge pills · Filter bar |
| `adminPanel.jsp` | Sidebar + table | Avatar initials · Approve/Reject modals · Live search · Export CSV |

---

## 🗄️ Database Schema

```sql
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DATABASE
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CREATE DATABASE leave_management_db;
USE leave_management_db;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TABLE 1: employees
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CREATE TABLE employees (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(100)          NOT NULL,
  email      VARCHAR(100) UNIQUE   NOT NULL,
  password   VARCHAR(100)          NOT NULL,
  role       ENUM('EMPLOYEE','ADMIN') DEFAULT 'EMPLOYEE',
  created_at TIMESTAMP             DEFAULT CURRENT_TIMESTAMP
);

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TABLE 2: leave_requests
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CREATE TABLE leave_requests (
  leaveId    INT AUTO_INCREMENT PRIMARY KEY,
  employeeId INT  NOT NULL,
  fromDate   DATE NOT NULL,
  toDate     DATE NOT NULL,
  reason     TEXT,
  status     ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  appliedOn  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (employeeId) REFERENCES employees(id)
);

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- DEFAULT ADMIN ACCOUNT
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO employees (name, email, password, role)
VALUES ('Admin User', 'admin@company.com', 'admin123', 'ADMIN');
```

### Entity Relationship

```
┌──────────────────────┐          ┌───────────────────────────┐
│      employees       │          │       leave_requests       │
├──────────────────────┤          ├───────────────────────────┤
│ id          INT  PK  │◄────┐    │ leaveId    INT  PK        │
│ name        VARCHAR  │     └────│ employeeId INT  FK        │
│ email       VARCHAR  │          │ fromDate   DATE           │
│ password    VARCHAR  │          │ toDate     DATE           │
│ role        ENUM     │          │ reason     TEXT           │
│ created_at  TIMESTAMP│          │ status     ENUM           │
└──────────────────────┘          │ appliedOn  TIMESTAMP      │
                                  └───────────────────────────┘
        OneToMany ──────────────────────── ManyToOne
```

---

## ⚙️ Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                         BROWSER                                  │
│              JSP + HTML5 + CSS3 + Vanilla JS                     │
│         (Glassmorphism UI · Animations · Custom Cursor)          │
└──────────────────────────┬───────────────────────────────────────┘
                           │ HTTP Request / Response
┌──────────────────────────▼───────────────────────────────────────┐
│                    APACHE TOMCAT 10.x                            │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │                      SERVLET LAYER                          │ │
│  │                                                             │ │
│  │  LoginServlet   RegisterServlet   DashboardServlet          │ │
│  │  ApplyLeaveServlet   ViewLeaveServlet   LogoutServlet        │ │
│  │  ApproveLeaveServlet   RejectLeaveServlet   AdminServlet     │ │
│  └──────────────────────────┬──────────────────────────────────┘ │
│                             │                                    │
│  ┌──────────────────────────▼──────────────────────────────────┐ │
│  │                       DAO LAYER                             │ │
│  │           EmployeeDao          LeaveDao                     │ │
│  └──────────────────────────┬──────────────────────────────────┘ │
│                             │                                    │
│  ┌──────────────────────────▼──────────────────────────────────┐ │
│  │              HIBERNATE ORM  (SessionFactory)                │ │
│  │         Employee.java       LeaveRequest.java               │ │
│  └──────────────────────────┬──────────────────────────────────┘ │
└─────────────────────────────┼────────────────────────────────────┘
                              │ JDBC
┌─────────────────────────────▼────────────────────────────────────┐
│                       MYSQL DATABASE                             │
│              employees  ·  leave_requests                        │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🌐 Servlet Routes

| Method | URL | Servlet | Role | Description |
|--------|-----|---------|------|-------------|
| POST | `/login` | `LoginServlet` | All | Authenticate user |
| POST | `/register` | `RegisterServlet` | All | Create new account |
| GET | `/dashboard` | `DashboardServlet` | Employee | Personal dashboard |
| POST | `/applyLeave` | `ApplyLeaveServlet` | Employee | Submit leave request |
| GET | `/viewLeaves` | `ViewLeaveServlet` | Employee | View own leaves |
| POST | `/approveLeave` | `ApproveLeaveServlet` | Admin | Approve a request |
| POST | `/rejectLeave` | `RejectLeaveServlet` | Admin | Reject a request |
| GET | `/adminPanel` | `AdminPanelServlet` | Admin | Full admin dashboard |
| GET | `/logout` | `LogoutServlet` | All | Invalidate session |

---

## 📁 Project Structure

```
EmployeeLeaveManagement/
│
├── 📄 pom.xml
│
└── src/
    └── main/
        ├── java/
        │   ├── 📦 model/
        │   │   ├── Employee.java           @Entity · id, name, email, password, role
        │   │   └── LeaveRequest.java       @Entity · leaveId, employee, dates, status
        │   │
        │   ├── 📦 dao/
        │   │   ├── EmployeeDao.java        register · login · findById · getAll
        │   │   └── LeaveDao.java           apply · getByEmp · getAll · updateStatus
        │   │
        │   ├── 📦 servlet/
        │   │   ├── LoginServlet.java
        │   │   ├── RegisterServlet.java
        │   │   ├── DashboardServlet.java
        │   │   ├── ApplyLeaveServlet.java
        │   │   ├── ViewLeaveServlet.java
        │   │   ├── ApproveLeaveServlet.java
        │   │   ├── RejectLeaveServlet.java
        │   │   ├── AdminPanelServlet.java
        │   │   └── LogoutServlet.java
        │   │
        │   └── 📦 util/
        │       └── HibernateUtil.java      Singleton SessionFactory
        │
        └── webapp/
            ├── 📂 css/
            │   └── style.css               All global styles + CSS variables
            ├── 📂 js/
            │   └── interactions.js         15 JS features (cursor, tilt, magnetic...)
            │
            ├── login.jsp                   Split screen · glitch art · glass form
            ├── register.jsp                Password strength meter · role selector
            ├── dashboard.jsp               Stats · timeline · quick apply · donut chart
            ├── applyLeave.jsp              Step form · duration calc · pill selector
            ├── viewLeaves.jsp              Floating table · status badges · filter bar
            ├── adminPanel.jsp              Approve/Reject · search · CSV export
            │
            └── WEB-INF/
                ├── web.xml
                └── hibernate.cfg.xml
```

---

## 🚀 Getting Started

### Prerequisites

```
✅ Java JDK 11 or higher
✅ Apache Maven 3.8+
✅ MySQL 8.0+
✅ Apache Tomcat 10.x
✅ IntelliJ IDEA (recommended) or Eclipse
```

### Step-by-step Setup

**1. Clone the repository**
```bash
git clone https://github.com/SomSatwik/Ajava.git
cd Ajava/EmployeeLeaveManagement
```

**2. Create the database**
```sql
CREATE DATABASE leave_management_db;
USE leave_management_db;

-- Run all CREATE TABLE statements from the Database Schema section above
-- Then insert the default admin:
INSERT INTO employees (name, email, password, role)
VALUES ('Admin User', 'admin@company.com', 'admin123', 'ADMIN');
```

**3. Configure your DB credentials**

Open `src/main/webapp/WEB-INF/hibernate.cfg.xml` and update:
```xml
<property name="connection.url">
    jdbc:mysql://localhost:3306/leave_management_db?useSSL=false&amp;serverTimezone=UTC
</property>
<property name="connection.username">root</property>
<property name="connection.password">YOUR_PASSWORD_HERE</property>
```

**4. Build the WAR file**
```bash
mvn clean package
```

**5. Deploy to Tomcat**
```bash
# Stop Tomcat
./bin/shutdown.sh      # Mac / Linux
bin\shutdown.bat       # Windows

# Copy WAR
cp target/EmployeeLeaveManagement.war /path/to/tomcat/webapps/

# Start Tomcat
./bin/startup.sh       # Mac / Linux
bin\startup.bat        # Windows
```

**6. Open in your browser**
```
http://localhost:8080/EmployeeLeaveManagement/
```

> 💡 **IntelliJ users:** Just configure a Tomcat run configuration, set **On Update → Redeploy**, and hit ▶ — no manual WAR copying needed.

---

## 🔑 Default Login Credentials

```
┌─────────────────────────────────────────────┐
│  👑 ADMIN                                   │
│     Email:     admin@company.com            │
│     Password:  admin123                     │
│     Access:    Full admin panel             │
├─────────────────────────────────────────────┤
│  👤 EMPLOYEE                                │
│     Register a new account at /register    │
│     Access:    Apply + view own leaves      │
└─────────────────────────────────────────────┘
```

---

## 🧩 Maven Dependencies

```xml
<!-- pom.xml — exact versions -->
<dependencies>

  <!-- Hibernate ORM -->
  <dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-core</artifactId>
    <version>5.6.15.Final</version>
  </dependency>

  <!-- MySQL Driver -->
  <dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
  </dependency>

  <!-- Servlet API -->
  <dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>5.0.0</version>
    <scope>provided</scope>
  </dependency>

  <!-- JSTL -->
  <dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
    <version>1.2</version>
  </dependency>

  <!-- JSP API -->
  <dependency>
    <groupId>javax.servlet.jsp</groupId>
    <artifactId>javax.servlet.jsp-api</artifactId>
    <version>2.3.3</version>
    <scope>provided</scope>
  </dependency>

</dependencies>
```

---

## 🎯 JS Interactions (`interactions.js`)

The entire frontend interactivity lives in one file with 15 features:

```
┌─────┬────────────────────────────┬────────────────────────────────────────┐
│  #  │  Feature                   │  How it works                          │
├─────┼────────────────────────────┼────────────────────────────────────────┤
│  1  │ Custom Cursor              │ Lerp-smoothed outer ring + inner dot   │
│  2  │ Magnetic Buttons           │ Button drifts ±10px toward cursor      │
│  3  │ 3D Card Tilt               │ perspective(1000px) rotateX/Y ±10deg   │
│  4  │ Click Ripple               │ Expanding circle at click coordinates  │
│  5  │ Stagger Fade-Up            │ Cards animate in with delay offsets    │
│  6  │ Live Clock                 │ Updates every second in header bar     │
│  7  │ Duration Calculator        │ fromDate + toDate → "X working days"   │
│  8  │ Char Counter               │ Textarea → live 0/500 counter          │
│  9  │ Password Strength          │ Length + special chars → color bar     │
│ 10  │ Table Status Filter        │ Pill buttons show/hide rows instantly  │
│ 11  │ Live Search                │ oninput filters table by employee name │
│ 12  │ Confirm Modal              │ Custom glass-card modal (not browser)  │
│ 13  │ Toast Notifications        │ Slides in bottom-right, auto-dismisses │
│ 14  │ Sidebar Toggle             │ Hamburger collapses sidebar on mobile  │
│ 15  │ Scroll Progress Bar        │ Violet line at top tracks scroll %     │
└─────┴────────────────────────────┴────────────────────────────────────────┘
```

---

## 🤝 Contributing

```bash
# 1. Fork this repo
# 2. Create your branch
git checkout -b feature/YourFeatureName

# 3. Make your changes and commit
git commit -m "feat: add YourFeatureName"

# 4. Push
git push origin feature/YourFeatureName

# 5. Open a Pull Request
```

---

## 🐛 Known Issues / Roadmap

- [ ] Password hashing (currently plain text — upgrade to BCrypt)
- [ ] Email notifications on leave approval/rejection
- [ ] Leave balance deduction logic
- [ ] Responsive mobile layout
- [ ] Forgot password flow
- [ ] Dark/light mode toggle
- [ ] PDF export of leave history

---

## 👨‍💻 Author

<div align="center">

**Som Satwik**

[![GitHub](https://img.shields.io/badge/GitHub-SomSatwik-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/SomSatwik)

</div>

---

## 📄 License

```
MIT License — free to use for learning, personal projects, and development.
```

---

<div align="center">

<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=12,20,24&height=120&section=footer"/>

**⭐ Star this repo if it helped you!**

*Built with ❤️ using Java · Hibernate · Servlet · JSP · MySQL*

</div>
