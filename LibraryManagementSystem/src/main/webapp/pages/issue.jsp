<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bibliox.model.*,java.util.*,java.time.*" %>
<%
  List<User> members = (List<User>) request.getAttribute("members");
  List<Book> books = (List<Book>) request.getAttribute("books");
  List<IssuedBook> issuedBooks = (List<IssuedBook>) request.getAttribute("issuedBooks");
  String error = request.getParameter("error");
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>BiblioX — Issue / Return</title>
  <link rel="stylesheet" href="<%=ctx%>/css/style.css"/>
</head>
<body>

<%@ include file="layout-top.jsp" %>

<div class="content">
  <div style="margin-bottom:28px;" class="fade-up">
    <div class="page-title">ISSUE <span>/</span> RETURN</div>
    <div class="page-sub">Manage book circulation</div>
  </div>

  <% if ("alreadyissued".equals(error)) { %>
  <div class="alert alert-danger fade-up" data-autodismiss>
    ✕ &nbsp; This member already has a book issued. They must return it first.
  </div>
  <% } else if ("unavailable".equals(error)) { %>
  <div class="alert alert-warn fade-up" data-autodismiss>
    ⚠ &nbsp; This book has no available copies right now.
  </div>
  <% } %>

  <div class="grid-2" style="margin-bottom:24px;">
    <!-- ISSUE FORM -->
    <div class="panel fade-up">
      <div class="panel-head">
        <div class="panel-title">
          <div class="panel-dot" style="background:var(--accent)"></div>
          Issue a Book
        </div>
      </div>
      <div class="panel-body" style="padding:22px;">
        <form method="POST" action="<%=ctx%>/issue">
          <input type="hidden" name="action" value="issue"/>
          <div class="form-group">
            <label class="form-label">Select Member *</label>
            <select name="userId" class="form-input" required>
              <option value="">— Choose member —</option>
              <% if (members != null) for (User m : members) {
                if (m.getRole() == Role.USER) { %>
              <option value="<%=m.getId()%>"><%=m.getName()%> (<%=m.getEmail()%>)</option>
              <% } } %>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">Select Book *</label>
            <select name="bookId" class="form-input" required>
              <option value="">— Choose book —</option>
              <% if (books != null) for (Book b : books) {
                if (b.getAvailableCopies() > 0) { %>
              <option value="<%=b.getId()%>"><%=b.getTitle()%> — <%=b.getAuthor()%> (<%=b.getAvailableCopies()%> left)</option>
              <% } } %>
            </select>
          </div>
          <div class="alert alert-warn" style="font-size:12px;margin-bottom:16px;">
            ⚠ &nbsp; Each member can hold only <b>1 book</b> at a time. Due date: 14 days from today.
          </div>
          <button type="submit" class="btn btn-accent" style="width:100%;justify-content:center;">
            Issue Book →
          </button>
        </form>
      </div>
    </div>

    <!-- ACTIVE ISSUES -->
    <div class="panel fade-up">
      <div class="panel-head">
        <div class="panel-title">
          <div class="panel-dot" style="background:var(--danger)"></div>
          Currently Issued
        </div>
        <div class="panel-badge"><%=issuedBooks != null ? issuedBooks.stream().filter(i->i.getStatus()==IssueStatus.ISSUED).count() : 0%> active</div>
      </div>
      <div class="panel-body">
        <% if (issuedBooks == null || issuedBooks.isEmpty()) { %>
        <div class="empty-state">
          <div class="empty-state-icon">✅</div>
          <div class="empty-state-text">All books returned</div>
        </div>
        <% } else {
          for (IssuedBook ib : issuedBooks) {
            if (ib.getStatus() != IssueStatus.ISSUED) continue;
            boolean overdue = ib.getDueDate() != null && ib.getDueDate().isBefore(LocalDateTime.now());
            long daysLeft = ib.getDueDate() != null ? java.time.temporal.ChronoUnit.DAYS.between(LocalDateTime.now(), ib.getDueDate()) : 0;
        %>
        <div style="display:flex;align-items:center;gap:12px;padding:12px 20px;border-bottom:0.5px solid var(--border);"
             class="<%= overdue ? "overdue-row" : ""%>">
          <div class="due-bar" style="background:<%=overdue?"var(--danger)":daysLeft<=3?"var(--warn)":"var(--success)"%>"></div>
          <div style="flex:1;min-width:0;">
            <div style="font-size:13px;color:var(--text);font-weight:500"><%=ib.getBook().getTitle()%></div>
            <div style="font-size:11px;color:var(--muted);font-family:var(--font-mono)">
              <%=ib.getUser().getName()%> ·
              <% if (overdue) { %><span style="color:var(--danger)"><%=Math.abs(daysLeft)%>d overdue</span>
              <% } else { %><span>due in <%=daysLeft%>d</span><% } %>
            </div>
          </div>
          <form method="POST" action="<%=ctx%>/issue">
            <input type="hidden" name="action" value="return"/>
            <input type="hidden" name="issuedBookId" value="<%=ib.getId()%>"/>
            <button type="submit" class="btn btn-outline btn-sm">Return</button>
          </form>
        </div>
        <% } } %>
      </div>
    </div>
  </div>
</div>

<%@ include file="layout-bottom.jsp" %>
