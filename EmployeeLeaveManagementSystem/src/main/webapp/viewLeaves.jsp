<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Employee, model.LeaveRequest, java.util.List" %>
<%
    Employee emp = (Employee) session.getAttribute("employee");
    if (emp == null) { response.sendRedirect("login"); return; }
    List<LeaveRequest> leaves = (List<LeaveRequest>) request.getAttribute("leaves");
    String initials = emp.getName().length() >= 2
        ? emp.getName().substring(0,2).toUpperCase()
        : emp.getName().toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Leaves — LeaveOS</title>
  <meta name="description" content="Track all your leave requests — LeaveOS"/>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Syne:wght@600;700;800&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
  <div class="bg-dot-grid"></div>
  <div class="bg-diagonal"></div>
  <div class="orb orb-a"></div>
  <div class="orb orb-b"></div>
  <div id="scroll-progress"></div>

  <!-- ── SIDEBAR ── -->
  <aside class="sidebar" id="sidebar">
    <div class="sidebar-logo">
      <div class="logo-icon">🛡️</div>
      <div class="logo-text">
        <div class="brand">LeaveOS</div>
        <div class="sub">Management System</div>
      </div>
    </div>
    <nav class="sidebar-nav">
      <div class="nav-label">Navigation</div>
      <a href="dashboard" class="nav-link">
        <span class="nav-icon">🏠</span> Dashboard
      </a>
      <a href="applyLeave" class="nav-link">
        <span class="nav-icon">📝</span> Apply Leave
      </a>
      <a href="viewLeaves" class="nav-link active">
        <span class="nav-icon">📋</span> My Leaves
      </a>
      <% if ("ADMIN".equals(emp.getRole())) { %>
      <div class="nav-label">Admin</div>
      <a href="adminPanel" class="nav-link">
        <span class="nav-icon">⚙️</span> Admin Panel
      </a>
      <% } %>
    </nav>
    <div class="sidebar-footer">
      <div class="user-card">
        <div class="user-card-top">
          <div class="avatar-circle"><%= initials %></div>
          <div class="user-info">
            <div class="user-name"><%= emp.getName() %></div>
            <div class="user-email"><%= emp.getEmail() %></div>
          </div>
        </div>
        <span class="role-badge <%= "ADMIN".equals(emp.getRole()) ? "role-admin" : "role-employee" %>"><%= emp.getRole() %></span>
      </div>
      <a href="logout" class="btn-logout">🚪 Sign Out</a>
    </div>
  </aside>

  <!-- ── MAIN CONTENT ── -->
  <main class="main-content">
    <header class="top-header">
      <div>
        <button class="hamburger" id="hamburger">☰</button>
        <div class="page-title">My Leaves</div>
        <div class="breadcrumb">Home / <span>My Leave Requests</span></div>
      </div>
      <div class="header-right">
        <div id="live-clock"></div>
        <div class="header-avatar"><%= initials %></div>
      </div>
    </header>

    <div class="content-area">
      <div class="glass-card" style="padding:28px;">
        <!-- Header Row -->
        <div class="flex-between" style="margin-bottom:24px;flex-wrap:wrap;gap:12px;">
          <div class="section-title">📋 Leave History</div>
          <a href="applyLeave" class="btn-primary btn-sm magnetic">+ Apply New Leave</a>
        </div>

        <!-- Filter Bar -->
        <div class="filter-bar">
          <button class="filter-pill active" data-filter="all">All Leaves</button>
          <button class="filter-pill" data-filter="PENDING">⏳ Pending</button>
          <button class="filter-pill" data-filter="APPROVED">✅ Approved</button>
          <button class="filter-pill" data-filter="REJECTED">❌ Rejected</button>
        </div>

        <!-- Table -->
        <% if (leaves == null || leaves.isEmpty()) { %>
        <div style="text-align:center;padding:64px 0;color:var(--text3);">
          <div style="font-size:3.5rem;margin-bottom:20px;">📭</div>
          <div style="font-size:1rem;font-weight:600;color:var(--text2);margin-bottom:8px;">No leaves found</div>
          <div style="font-size:0.85rem;">You haven't applied for any leaves yet.</div>
          <a href="applyLeave" class="btn-primary" style="display:inline-flex;margin-top:20px;padding:10px 22px;">Apply Now →</a>
        </div>
        <% } else { %>
        <div class="table-wrapper">
          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>Duration</th>
                <th>Reason</th>
                <th>Applied On</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <% int i = 1; for (LeaveRequest lr : leaves) {
                 long diff = lr.getToDate().getTime() - lr.getFromDate().getTime();
                 long days = (diff / (1000 * 60 * 60 * 24)) + 1;
                 String statusClass = lr.getStatus().toLowerCase();
              %>
              <tr data-status="<%= lr.getStatus() %>">
                <td style="color:var(--text3);font-size:0.8rem;"><%= i++ %></td>
                <td><span style="font-weight:600;"><%= lr.getFromDate() %></span></td>
                <td><span style="font-weight:600;"><%= lr.getToDate() %></span></td>
                <td>
                  <span style="background:rgba(124,58,237,0.1);color:var(--violet-light);padding:3px 10px;border-radius:20px;font-size:0.78rem;font-weight:600;">
                    <%= days %> day<%= days != 1 ? "s" : "" %>
                  </span>
                </td>
                <td style="max-width:240px;">
                  <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--text2);font-size:0.85rem;">
                    <%= lr.getReason() != null ? lr.getReason() : "—" %>
                  </div>
                </td>
                <td style="color:var(--text3);font-size:0.8rem;">
                  <%= lr.getAppliedOn() != null ? lr.getAppliedOn().toString().substring(0,10) : "N/A" %>
                </td>
                <td>
                  <span class="badge badge-<%= statusClass %>">
                    <%= "APPROVED".equals(lr.getStatus()) ? "✓" : "REJECTED".equals(lr.getStatus()) ? "✗" : "●" %> <%= lr.getStatus() %>
                  </span>
                </td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>
        <% } %>
      </div>
    </div>
  </main>

  <div id="toast"></div>
  <script src="js/interactions.js"></script>
</body>
</html>
