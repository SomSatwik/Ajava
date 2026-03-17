<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bibliox.model.*,java.util.*,java.time.*,java.time.temporal.*" %>
<%
  IssuedBook activeBook = (IssuedBook) request.getAttribute("activeBook");
  List<IssuedBook> history = (List<IssuedBook>) request.getAttribute("history");
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>BiblioX — My Books</title>
  <link rel="stylesheet" href="<%=ctx%>/css/style.css"/>
</head>
<body>

<%@ include file="layout-top.jsp" %>

<div class="content">
  <div style="margin-bottom:28px;" class="fade-up">
    <div class="page-title">MY <span>BOOKS</span></div>
    <div class="page-sub">Your reading history</div>
  </div>

  <!-- ACTIVE BOOK -->
  <% if (activeBook != null) {
    long daysLeft = activeBook.getDueDate() != null
        ? ChronoUnit.DAYS.between(LocalDateTime.now(), activeBook.getDueDate()) : 0;
    boolean overdue = daysLeft < 0;
    String countdownClass = overdue ? "danger" : daysLeft <= 3 ? "warn" : "safe";
  %>
  <div class="big-book-card fade-up" style="margin-bottom:24px;">
    <div style="display:flex;gap:20px;align-items:flex-start;">
      <div class="book-spine" data-title="<%=activeBook.getBook().getTitle()%>"
           style="width:64px;height:88px;font-size:14px;border-radius:8px;flex-shrink:0;">
        <%=activeBook.getBook().getTitle().substring(0,Math.min(3,activeBook.getBook().getTitle().length())).toUpperCase()%>
      </div>
      <div style="flex:1">
        <div class="big-book-title"><%=activeBook.getBook().getTitle()%></div>
        <div class="big-book-author">by <%=activeBook.getBook().getAuthor()%></div>

        <div style="display:flex;gap:24px;flex-wrap:wrap;">
          <div>
            <div style="font-family:var(--font-mono);font-size:10px;color:var(--muted);text-transform:uppercase;letter-spacing:1px;margin-bottom:4px;">Issued On</div>
            <div style="font-size:14px;color:var(--text)"><%=activeBook.getIssuedDate() != null ? activeBook.getIssuedDate().toLocalDate() : "—"%></div>
          </div>
          <div>
            <div style="font-family:var(--font-mono);font-size:10px;color:var(--muted);text-transform:uppercase;letter-spacing:1px;margin-bottom:4px;">Due Date</div>
            <div style="font-size:14px;color:var(--text)"><%=activeBook.getDueDate() != null ? activeBook.getDueDate().toLocalDate() : "—"%></div>
          </div>
          <div>
            <div style="font-family:var(--font-mono);font-size:10px;color:var(--muted);text-transform:uppercase;letter-spacing:1px;margin-bottom:4px;">
              <%=overdue ? "Overdue By" : "Days Left"%>
            </div>
            <div class="due-countdown <%=countdownClass%>">
              <%=Math.abs(daysLeft)%> days
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <% if (overdue) { %>
  <div class="alert alert-danger fade-up" style="margin-bottom:24px;">
    ⚠ &nbsp; Your book is <b><%=Math.abs(daysLeft)%> days overdue</b>. Please return it immediately.
  </div>
  <% } else if (daysLeft <= 3) { %>
  <div class="alert alert-warn fade-up" style="margin-bottom:24px;">
    ⚠ &nbsp; Due in <b><%=daysLeft%> days</b>. Please return it soon.
  </div>
  <% } %>

  <% } else { %>
  <div class="panel fade-up" style="margin-bottom:24px;">
    <div class="panel-body">
      <div class="empty-state" style="padding:48px;">
        <div class="empty-state-icon">📚</div>
        <div class="empty-state-text" style="font-size:15px;color:var(--muted)">
          No book currently issued.<br/>
          <span style="font-size:12px;">Visit the library to borrow a book.</span>
        </div>
      </div>
    </div>
  </div>
  <% } %>

  <!-- HISTORY -->
  <div class="panel fade-up">
    <div class="panel-head">
      <div class="panel-title">
        <div class="panel-dot" style="background:var(--muted)"></div>
        Borrow History
      </div>
      <div class="panel-badge"><%=history != null ? history.size() : 0%> records</div>
    </div>
    <div class="panel-body">
      <% if (history == null || history.isEmpty()) { %>
      <div class="empty-state">
        <div class="empty-state-text">No history yet</div>
      </div>
      <% } else { %>
      <table class="data-table">
        <thead>
          <tr>
            <th>Book</th>
            <th>Issued</th>
            <th>Due</th>
            <th>Returned</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <% for (IssuedBook ib : history) {
            String pillClass = ib.getStatus() == IssueStatus.RETURNED ? "returned"
                             : ib.getStatus() == IssueStatus.OVERDUE ? "overdue" : "issued";
          %>
          <tr>
            <td style="font-weight:500;color:var(--text)"><%=ib.getBook().getTitle()%></td>
            <td style="font-family:var(--font-mono);font-size:12px"><%=ib.getIssuedDate() != null ? ib.getIssuedDate().toLocalDate() : "—"%></td>
            <td style="font-family:var(--font-mono);font-size:12px"><%=ib.getDueDate() != null ? ib.getDueDate().toLocalDate() : "—"%></td>
            <td style="font-family:var(--font-mono);font-size:12px"><%=ib.getReturnDate() != null ? ib.getReturnDate().toLocalDate() : "—"%></td>
            <td><span class="pill <%=pillClass%>"><%=ib.getStatus().name()%></span></td>
          </tr>
          <% } %>
        </tbody>
      </table>
      <% } %>
    </div>
  </div>
</div>

<%@ include file="layout-bottom.jsp" %>
