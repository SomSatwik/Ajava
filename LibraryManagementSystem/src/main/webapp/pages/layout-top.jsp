<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bibliox.model.User, com.bibliox.model.Role" %>
<%
  User __u = (User) session.getAttribute("currentUser");
  String __role = __u != null ? __u.getRole().name() : "USER";
  String __name = __u != null ? __u.getName() : "";
  String __initials = __name.length() >= 2 ? __name.substring(0,2).toUpperCase() : "??";
  String __chipClass = "USER".equals(__role) ? "user" : ("ADMIN".equals(__role) ? "admin" : "super-admin");
  String __chipLabel = "SUPER_ADMIN".equals(__role) ? "SUPER ADMIN" : __role;
  String __ctx = request.getContextPath();
  String __path = request.getServletPath();
%>

<div class="grid-bg"></div>
<div class="app-layout">
  <!-- SIDEBAR -->
  <nav class="sidebar">
    <div class="sidebar-logo">B<span>X</span></div>

    <% if (!"USER".equals(__role)) { %>
    <a href="<%=__ctx%>/dashboard" class="nav-item <%= __path.contains("dashboard") ? "active" : "" %>">
      ⊞ <span class="nav-tooltip">Dashboard</span>
    </a>
    <% } %>

    <a href="<%=__ctx%>/books" class="nav-item <%= __path.contains("books") ? "active" : "" %>">
      📚 <span class="nav-tooltip">Books</span>
    </a>

    <% if (!"USER".equals(__role)) { %>
    <a href="<%=__ctx%>/members" class="nav-item <%= __path.contains("members") ? "active" : "" %>">
      👥 <span class="nav-tooltip">Members</span>
    </a>
    <a href="<%=__ctx%>/issue" class="nav-item <%= __path.contains("issue") ? "active" : "" %>">
      ↕ <span class="nav-tooltip">Issue / Return</span>
    </a>
    <% } else { %>
    <a href="<%=__ctx%>/my-books" class="nav-item <%= __path.contains("my-books") ? "active" : "" %>">
      🔖 <span class="nav-tooltip">My Books</span>
    </a>
    <% } %>

    <div class="nav-divider"></div>
    <a href="<%=__ctx%>/logout" class="nav-item">
      ⏏ <span class="nav-tooltip">Logout</span>
    </a>

    <div class="sidebar-avatar"><%=__initials%></div>
  </nav>

  <!-- MAIN -->
  <div class="main-area">
    <!-- TOPBAR -->
    <header class="topbar">
      <div class="topbar-brand">BiblioX</div>
      <div class="topbar-path">/ <span><%=__path.replace("/","")%></span></div>
      <div style="flex:1"></div>
      <span class="role-chip <%=__chipClass%>"><%=__chipLabel%></span>
      <span style="font-size:13px;color:var(--muted);font-family:var(--font-mono)"><%=__name%></span>
      <a href="<%=__ctx%>/logout" class="topbar-logout">logout</a>
    </header>

    <!-- PAGE CONTENT BELOW -->
