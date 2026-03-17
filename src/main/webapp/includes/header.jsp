<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University Management System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Big+Shoulders+Display:wght@700;800&family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600&family=Syne:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-dark: #09090f;
            --text-main: #f0f0f8;
            --text-muted: #888899;
            --purple-main: #6c63ff;
            --purple-alt: #8b5cf6;
            --nav-bg: rgba(9, 9, 15, 0.85);
            --border-light: rgba(255, 255, 255, 0.05);
            --card-bg: #111118;
            --card-badge: #1a1a26;
            --accent-green: #00d4aa;
            --accent-pink: #ff6b9d;
            --accent-amber: #f59e0b;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: var(--bg-dark);
            color: var(--text-main);
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            position: relative;
            background-image: 
                linear-gradient(rgba(255, 255, 255, 0.05) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
            background-size: 50px 50px;
        }

        h1, h2, h3, h4, .heading-font {
            font-family: 'Syne', sans-serif;
        }

        /* Ambient Orbs */
        .orb {
            position: fixed;
            z-index: -1;
            border-radius: 50%;
            pointer-events: none;
            filter: blur(80px);
        }
        .orb-1 {
            top: -100px;
            left: -100px;
            width: 400px;
            height: 400px;
            background: rgba(108, 99, 255, 0.25);
        }
        .orb-2 {
            bottom: -50px;
            right: -50px;
            width: 500px;
            height: 500px;
            background: rgba(255, 107, 157, 0.2);
        }
        .orb-3 {
            top: 40%;
            right: 15%;
            width: 300px;
            height: 300px;
            background: rgba(0, 212, 170, 0.12);
        }

        /* Navbar */
        .navbar {
            position: sticky;
            top: 0;
            background: var(--nav-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.07);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.5rem 2rem;
            height: 80px;
            z-index: 100;
        }

        .nav-left {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            cursor: pointer;
        }

        .nav-logo {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--purple-main), var(--purple-alt));
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: 1.4rem;
            color: #fff;
        }

        .nav-brand {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .nav-title {
            color: #fff;
            font-family: 'DM Sans', sans-serif;
            font-weight: 700;
            font-size: 1.1rem;
            line-height: 1.2;
        }

        .nav-subtitle {
            color: var(--text-muted);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.75rem;
            line-height: 1.2;
        }

        .nav-center {
            display: flex;
            gap: 1rem;
        }

        .nav-link {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.2s ease;
            position: relative;
        }

        .nav-link:hover {
            background-color: var(--card-badge);
            color: #fff;
        }

        .nav-link.active {
            color: #fff;
        }

        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -6px;
            left: 50%;
            transform: translateX(-50%);
            width: 6px;
            height: 6px;
            background-color: var(--purple-main);
            border-radius: 50%;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .btn {
            cursor: pointer;
            font-family: 'DM Sans', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: none;
        }

        .btn-ghost {
            background: transparent;
            color: #fff;
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .btn-ghost:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--purple-main), var(--purple-alt));
            color: #fff;
            box-shadow: 0 4px 15px rgba(108, 99, 255, 0.3);
        }

        .btn-primary:hover {
            box-shadow: 0 6px 20px rgba(108, 99, 255, 0.5);
            transform: translateY(-1px);
        }

        .btn-dark {
            background: var(--card-badge);
            color: #fff;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .btn-dark:hover {
            background: #232333;
        }

        .main-content {
            flex: 1;
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <% 
       String currentURI = request.getRequestURI();
       boolean isIndex = currentURI.endsWith("index.jsp") || currentURI.endsWith("/");
       boolean isStudents = currentURI.endsWith("students.jsp") || currentURI.endsWith("/students");
       boolean isAddStudent = currentURI.endsWith("addStudent.jsp");
       boolean isTestDB = false;
       boolean isTestServlet = false;
    %>

    <nav class="navbar">
        <a href="index.jsp" class="nav-left">
            <div class="nav-logo">U</div>
            <div class="nav-brand">
                <span class="nav-title">UniManage</span>
                <span class="nav-subtitle">Management System</span>
            </div>
        </a>
        
        <div class="nav-center">
            <a href="students" class="nav-link <%= isStudents && !isAddStudent ? "active" : "" %>">Students</a>
            <a href="addStudent.jsp" class="nav-link <%= isAddStudent ? "active" : "" %>">Add Student</a>
            <a href="#" class="nav-link">About</a>
            <a href="#" class="nav-link">Test DB</a>
            <a href="#" class="nav-link">Test Servlet</a>
        </div>
        
        <div class="nav-right">
            <a href="#" class="btn btn-ghost">Sign In</a>
            <a href="#" class="btn btn-primary">Get Started</a>
        </div>
    </nav>
    <div class="main-content">
