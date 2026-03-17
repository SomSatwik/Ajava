<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bibliox.model.*,java.util.*" %>
<%
  List<User> members = (List<User>) request.getAttribute("members");
  User cu = (User) session.getAttribute("currentUser");
  boolean isSuperAdmin = cu != null && cu.getRole() == Role.SUPER_ADMIN;
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>BiblioX — Members</title>
  <link rel="stylesheet" href="<%=ctx%>/css/style.css"/>
</head>
<body>

<%@ include file="layout-top.jsp" %>

<div class="content">
  <div style="margin-bottom:28px;" class="fade-up">
    <div class="page-title">MEM<span>BERS</span></div>
    <div class="page-sub"><%=members != null ? members.size() : 0%> registered users</div>
  </div>

  <!-- SEARCH -->
  <div style="margin-bottom:20px;" class="fade-up">
    <div class="topbar-search" style="width:100%;max-width:400px;">
      <span class="search-icon">⌕</span>
      <input type="text" id="member-search" placeholder="Search members..."/>
    </div>
  </div>

  <div class="panel fade-up">
    <div class="panel-head">
      <div class="panel-title">
        <div class="panel-dot" style="background:var(--success)"></div>
        All Members
      </div>
      <div class="panel-badge">Role-Based Access</div>
    </div>
    <div class="panel-body">
      <% if (members == null || members.isEmpty()) { %>
      <div class="empty-state">
        <div class="empty-state-icon">👥</div>
        <div class="empty-state-text">No members found</div>
      </div>
      <% } else { %>
      <table class="data-table">
        <thead>
          <tr>
            <th>Member</th>
            <th>Email</th>
            <th>Role</th>
            <th>Joined</th>
            <% if (isSuperAdmin) { %><th>Change Role</th><% } %>
          </tr>
        </thead>
        <tbody>
          <% for (User m : members) {
            String initials = m.getName().length() >= 2 ? m.getName().substring(0,2).toUpperCase() : "??";
            String roleClass = m.getRole() == Role.SUPER_ADMIN ? "role-super"
                             : m.getRole() == Role.ADMIN ? "role-admin" : "role-user";
            String[] avColors = {"#6C3FFF33,#A87BFF", "#FF2F5B22,#FF6B9D", "#00FFB322,#7BFFCC",
                                 "#FFB30022,#FFD07B", "#3F9FFF22,#7BBFFF"};
            int colorIdx = Math.abs(m.getName().hashCode()) % avColors.length;
            String[] parts = avColors[colorIdx].split(",");
          %>
          <tr class="member-row">
            <td>
              <div style="display:flex;align-items:center;gap:10px;">
                <div class="m-avatar" style="background:<%=parts[0]%>;color:<%=parts[1]%>">
                  <%=initials%>
                </div>
                <div style="font-weight:500;color:var(--text)"><%=m.getName()%></div>
              </div>
            </td>
            <td style="font-family:var(--font-mono);font-size:12px;color:var(--muted)"><%=m.getEmail()%></td>
            <td><span class="pill <%=roleClass%>"><%=m.getRole().name().replace("_"," ")%></span></td>
            <td style="font-family:var(--font-mono);font-size:11px;color:var(--muted)">
              <%=m.getCreatedAt() != null ? m.getCreatedAt().toLocalDate() : "—"%>
            </td>
            <% if (isSuperAdmin && !m.getId().equals(cu.getId())) { %>
            <td>
              <form method="POST" action="<%=ctx%>/members" style="display:flex;gap:8px;align-items:center">
                <input type="hidden" name="userId" value="<%=m.getId()%>"/>
                <select name="role" class="form-input" style="width:auto;padding:5px 10px;font-size:12px;">
                  <option value="USER" <%=m.getRole()==Role.USER?"selected":""%>>User</option>
                  <option value="ADMIN" <%=m.getRole()==Role.ADMIN?"selected":""%>>Admin</option>
                  <option value="SUPER_ADMIN" <%=m.getRole()==Role.SUPER_ADMIN?"selected":""%>>Super Admin</option>
                </select>
                <button type="submit" class="btn btn-outline btn-sm">Save</button>
              </form>
            </td>
            <% } else if (isSuperAdmin) { %>
            <td><span style="font-size:11px;color:var(--muted);font-family:var(--font-mono)">You</span></td>
            <% } %>
          </tr>
          <% } %>
        </tbody>
      </table>
      <% } %>
    </div>
  </div>
</div>

<%@ include file="layout-bottom.jsp" %>
