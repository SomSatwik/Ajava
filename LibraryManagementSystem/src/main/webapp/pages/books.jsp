<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bibliox.model.*,java.util.*" %>
<%
  List<Book> books = (List<Book>) request.getAttribute("books");
  String searchQuery = (String) request.getAttribute("searchQuery");
  User cu = (User) session.getAttribute("currentUser");
  boolean isAdmin = cu != null && cu.getRole() != Role.USER;
  boolean isSuperAdmin = cu != null && cu.getRole() == Role.SUPER_ADMIN;
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>BiblioX — Books</title>
  <link rel="stylesheet" href="<%=ctx%>/css/style.css"/>
</head>
<body>

<%@ include file="layout-top.jsp" %>

<div class="content">
  <div style="display:flex;align-items:flex-end;justify-content:space-between;margin-bottom:28px;" class="fade-up">
    <div>
      <div class="page-title">BOOK<span>S</span></div>
      <div class="page-sub"><%=books != null ? books.size() : 0%> titles in catalogue</div>
    </div>
    <% if (isAdmin) { %>
    <button class="btn btn-accent" onclick="openPanel('add-book-panel')">+ Add Book</button>
    <% } %>
  </div>

  <!-- SEARCH -->
  <form method="GET" action="<%=ctx%>/books" style="margin-bottom:20px;" class="fade-up">
    <div class="topbar-search" style="width:100%;max-width:400px;">
      <span class="search-icon">⌕</span>
      <input type="text" name="q" id="book-search"
             placeholder="Search title, author, genre..."
             value="<%=searchQuery != null ? searchQuery : ""%>"/>
    </div>
  </form>

  <!-- TABLE -->
  <div class="panel fade-up">
    <div class="panel-head">
      <div class="panel-title">
        <div class="panel-dot" style="background:var(--accent)"></div>
        Catalogue
      </div>
      <div class="panel-badge"><%=books != null ? books.size() : 0%> entries</div>
    </div>
    <div class="panel-body">
      <% if (books == null || books.isEmpty()) { %>
      <div class="empty-state">
        <div class="empty-state-icon">📚</div>
        <div class="empty-state-text">No books found</div>
      </div>
      <% } else { %>
      <table class="data-table">
        <thead>
          <tr>
            <th style="width:50px"></th>
            <th>Title</th>
            <th>Author</th>
            <th>Genre</th>
            <th>Copies</th>
            <th>Status</th>
            <% if (isSuperAdmin) { %><th></th><% } %>
          </tr>
        </thead>
        <tbody>
          <% for (Book b : books) {
            String abbr = b.getTitle().length() >= 3 ? b.getTitle().substring(0,3).toUpperCase() : b.getTitle().toUpperCase();
            String statusClass = b.getAvailableCopies() > 0 ? "available" : "issued";
            String statusLabel = b.getAvailableCopies() > 0 ? "Available" : "Issued Out";
          %>
          <tr class="book-row">
            <td>
              <div class="book-spine" data-title="<%=b.getTitle()%>"><%=abbr%></div>
            </td>
            <td>
              <div style="font-weight:500;color:var(--text)"><%=b.getTitle()%></div>
              <div style="font-size:11px;color:var(--muted);font-family:var(--font-mono)"><%=b.getIsbn() != null ? b.getIsbn() : "—"%></div>
            </td>
            <td><%=b.getAuthor()%></td>
            <td><span class="genre-tag"><%=b.getGenre() != null ? b.getGenre() : "—"%></span></td>
            <td>
              <span style="font-family:var(--font-mono);font-size:12px">
                <%=b.getAvailableCopies()%> / <%=b.getTotalCopies()%>
              </span>
            </td>
            <td><span class="pill <%=statusClass%>"><%=statusLabel%></span></td>
            <% if (isSuperAdmin) { %>
            <td>
              <form method="POST" action="<%=ctx%>/books" id="del-<%=b.getId()%>" style="display:inline">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="bookId" value="<%=b.getId()%>"/>
                <button type="button" class="btn btn-danger btn-sm"
                        onclick="confirmDelete('del-<%=b.getId()%>', 'Delete \'<%=b.getTitle()%>\'?')">
                  ✕
                </button>
              </form>
            </td>
            <% } %>
          </tr>
          <% } %>
        </tbody>
      </table>
      <% } %>
    </div>
  </div>
</div>

<!-- ADD BOOK SLIDE PANEL -->
<% if (isAdmin) { %>
<div class="slide-panel-overlay" id="add-book-panel-overlay" onclick="closePanel('add-book-panel')"></div>
<div class="slide-panel" id="add-book-panel">
  <button class="slide-panel-close" onclick="closePanel('add-book-panel')">✕</button>
  <div class="slide-panel-title">Add Book</div>

  <form method="POST" action="<%=ctx%>/books">
    <input type="hidden" name="action" value="add"/>
    <div class="form-group">
      <label class="form-label">Title *</label>
      <input type="text" name="title" class="form-input" required placeholder="Book title"/>
    </div>
    <div class="form-group">
      <label class="form-label">Author *</label>
      <input type="text" name="author" class="form-input" required placeholder="Author name"/>
    </div>
    <div class="form-row">
      <div class="form-group">
        <label class="form-label">ISBN</label>
        <input type="text" name="isbn" class="form-input" placeholder="978-..."/>
      </div>
      <div class="form-group">
        <label class="form-label">Genre</label>
        <input type="text" name="genre" class="form-input" placeholder="e.g. Engineering"/>
      </div>
    </div>
    <div class="form-group">
      <label class="form-label">Total Copies *</label>
      <input type="number" name="totalCopies" class="form-input" required min="1" value="1"/>
    </div>
    <button type="submit" class="btn btn-accent" style="width:100%;justify-content:center;margin-top:8px;">
      Add to Catalogue →
    </button>
  </form>
</div>
<% } %>

<%@ include file="layout-bottom.jsp" %>
