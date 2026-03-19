<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Employee, model.LeaveRequest, java.util.List" %>
<%
    Employee emp = (Employee) session.getAttribute("employee");
    if (emp == null) { response.sendRedirect("login"); return; }
    if (!"ADMIN".equals(emp.getRole())) { response.sendRedirect("dashboard"); return; }
    List<LeaveRequest> allLeaves = (List<LeaveRequest>) request.getAttribute("allLeaves");
    Long pendingCount = (Long) request.getAttribute("pendingCount");
    Long approvedCount = (Long) request.getAttribute("approvedCount");
    Long rejectedCount = (Long) request.getAttribute("rejectedCount");
    Long totalRequests = (Long) request.getAttribute("totalRequests");
    Integer employeeCount = (Integer) request.getAttribute("employeeCount");
    if (pendingCount == null) pendingCount = 0L;
    if (approvedCount == null) approvedCount = 0L;
    if (rejectedCount == null) rejectedCount = 0L;
    if (totalRequests == null) totalRequests = 0L;
    if (employeeCount == null) employeeCount = 0;
    String initials = emp.getName().length() >= 2
        ? emp.getName().substring(0,2).toUpperCase()
        : emp.getName().toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Panel — LeaveOS</title>
  <meta name="description" content="Admin control panel — manage all employee leave requests"/>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Syne:wght@600;700;800&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
  <div class="bg-dot-grid"></div>
  <div class="bg-diagonal"></div>
  <div class="orb orb-a"></div>
  <div class="orb orb-b"></div>
  <div class="orb orb-c"></div>
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
      <div class="nav-label">Employee</div>
      <a href="dashboard" class="nav-link">
        <span class="nav-icon">🏠</span> Dashboard
      </a>
      <a href="applyLeave" class="nav-link">
        <span class="nav-icon">📝</span> Apply Leave
      </a>
      <a href="viewLeaves" class="nav-link">
        <span class="nav-icon">📋</span> My Leaves
      </a>
      <div class="nav-label">Admin</div>
      <a href="adminPanel" class="nav-link active">
        <span class="nav-icon">⚙️</span> Admin Panel
      </a>
    </nav>
    <div class="sidebar-footer">
      <div class="user-card">
        <div class="user-card-top">
          <div class="avatar-circle" style="background:linear-gradient(135deg,#7c3aed,#f43f5e);"><%= initials %></div>
          <div class="user-info">
            <div class="user-name"><%= emp.getName() %></div>
            <div class="user-email"><%= emp.getEmail() %></div>
          </div>
        </div>
        <span class="role-badge role-admin"><%= emp.getRole() %></span>
      </div>
      <a href="logout" class="btn-logout">🚪 Sign Out</a>
    </div>
  </aside>

  <!-- ── MAIN CONTENT ── -->
  <main class="main-content">
    <header class="top-header">
      <div>
        <button class="hamburger" id="hamburger">☰</button>
        <div class="page-title">Admin Panel</div>
        <div class="breadcrumb">Home / <span>Admin Control</span></div>
      </div>
      <div class="header-right">
        <div id="live-clock"></div>
        <button class="notif-bell" title="Notifications">🔔 <span class="notif-dot"></span></button>
        <div class="header-avatar" style="background:linear-gradient(135deg,#7c3aed,#f43f5e);"><%= initials %></div>
      </div>
    </header>

    <div class="content-area">
      <!-- ── STATS ROW ── -->
      <div class="stats-grid" style="margin-bottom:28px;">
        <!-- Total Employees -->
        <div class="glass-card stat-card tilt-card">
          <div class="stat-icon-box" style="background:rgba(6,182,212,0.15);">👥</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#67e8f9,#06b6d4);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= employeeCount %>
          </div>
          <div class="stat-label">Total Employees</div>
          <div class="stat-trend trend-up">↑ Team members</div>
          <div class="sparkline" style="color:var(--cyan);">
            <div class="spark-bar" style="height:50%;"></div>
            <div class="spark-bar" style="height:70%;"></div>
            <div class="spark-bar" style="height:60%;"></div>
            <div class="spark-bar" style="height:80%;"></div>
            <div class="spark-bar active" style="height:100%;"></div>
          </div>
        </div>

        <!-- Pending -->
        <div class="glass-card stat-card tilt-card" style="animation-delay:0.08s;">
          <div class="stat-icon-box" style="background:rgba(245,158,11,0.15);">⏳</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#fcd34d,#f59e0b);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= pendingCount %>
          </div>
          <div class="stat-label">Pending Requests</div>
          <div class="stat-trend" style="color:var(--amber);">● Requires action</div>
          <div class="sparkline" style="color:var(--amber);">
            <div class="spark-bar" style="height:80%;"></div>
            <div class="spark-bar" style="height:50%;"></div>
            <div class="spark-bar" style="height:90%;"></div>
            <div class="spark-bar" style="height:60%;"></div>
            <div class="spark-bar active" style="height:70%;"></div>
          </div>
        </div>

        <!-- Approved -->
        <div class="glass-card stat-card tilt-card" style="animation-delay:0.16s;">
          <div class="stat-icon-box" style="background:rgba(16,185,129,0.15);">✅</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#6ee7b7,#10b981);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= approvedCount %>
          </div>
          <div class="stat-label">Approved</div>
          <div class="stat-trend trend-up">↑ Approved today</div>
          <div class="sparkline" style="color:var(--green);">
            <div class="spark-bar" style="height:30%;"></div>
            <div class="spark-bar" style="height:60%;"></div>
            <div class="spark-bar" style="height:80%;"></div>
            <div class="spark-bar" style="height:55%;"></div>
            <div class="spark-bar active" style="height:90%;"></div>
          </div>
        </div>

        <!-- Total Requests -->
        <div class="glass-card stat-card tilt-card" style="animation-delay:0.24s;">
          <div class="stat-icon-box" style="background:rgba(124,58,237,0.15);">📊</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#a78bfa,#7c3aed);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= totalRequests %>
          </div>
          <div class="stat-label">Total Requests</div>
          <div class="stat-trend trend-up">↑ All time</div>
          <div class="sparkline" style="color:var(--violet);">
            <div class="spark-bar" style="height:40%;"></div>
            <div class="spark-bar" style="height:65%;"></div>
            <div class="spark-bar" style="height:75%;"></div>
            <div class="spark-bar" style="height:50%;"></div>
            <div class="spark-bar active" style="height:100%;"></div>
          </div>
        </div>
      </div>

      <!-- ── LEAVE REQUESTS TABLE ── -->
      <div class="glass-card" style="padding:28px;">
        <div class="flex-between" style="margin-bottom:20px;flex-wrap:wrap;gap:12px;">
          <div class="section-title">📋 All Leave Requests</div>
          <button class="btn-export" onclick="exportCSV()">📥 Export CSV</button>
        </div>

        <!-- Search + Filter Bar -->
        <div class="filter-bar" style="margin-bottom:20px;">
          <input type="text" id="search-input" class="search-input" placeholder="🔍 Search by employee name..."/>
          <button class="filter-pill active" data-filter="all">All</button>
          <button class="filter-pill" data-filter="PENDING">⏳ Pending</button>
          <button class="filter-pill" data-filter="APPROVED">✅ Approved</button>
          <button class="filter-pill" data-filter="REJECTED">❌ Rejected</button>
        </div>

        <!-- Table -->
        <% if (allLeaves == null || allLeaves.isEmpty()) { %>
        <div style="text-align:center;padding:64px 0;color:var(--text3);">
          <div style="font-size:3.5rem;margin-bottom:20px;">📭</div>
          <div style="font-size:1rem;font-weight:600;color:var(--text2);">No leave requests found</div>
          <div style="font-size:0.85rem;margin-top:8px;">Leave requests from employees will appear here</div>
        </div>
        <% } else { %>
        <div class="table-wrapper">
          <table id="admin-table">
            <thead>
              <tr>
                <th>#</th>
                <th>Employee</th>
                <th>From</th>
                <th>To</th>
                <th>Duration</th>
                <th>Reason</th>
                <th>Applied</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <% int idx = 1; for (LeaveRequest lr : allLeaves) {
                 long diff = lr.getToDate().getTime() - lr.getFromDate().getTime();
                 long days = (diff / (1000 * 60 * 60 * 24)) + 1;
                 String statusClass = lr.getStatus().toLowerCase();
                 boolean actioned = "APPROVED".equals(lr.getStatus()) || "REJECTED".equals(lr.getStatus());
                 String empName = lr.getEmployee() != null ? lr.getEmployee().getName() : "Unknown";
                 String empEmail = lr.getEmployee() != null ? lr.getEmployee().getEmail() : "";
                 String empInit = empName.length() >= 2 ? empName.substring(0,2).toUpperCase() : empName.toUpperCase();
              %>
              <tr data-status="<%= lr.getStatus() %>" class="<%= actioned ? "dimmed" : "" %>">
                <td style="color:var(--text3);font-size:0.8rem;"><%= idx++ %></td>
                <td>
                  <div class="td-employee">
                    <div class="td-avatar"><%= empInit %></div>
                    <div>
                      <div class="td-name"><%= empName %></div>
                      <div class="td-email"><%= empEmail %></div>
                    </div>
                  </div>
                </td>
                <td style="font-weight:600;font-size:0.85rem;"><%= lr.getFromDate() %></td>
                <td style="font-weight:600;font-size:0.85rem;"><%= lr.getToDate() %></td>
                <td>
                  <span style="background:rgba(124,58,237,0.1);color:var(--violet-light);padding:3px 10px;border-radius:20px;font-size:0.75rem;font-weight:600;">
                    <%= days %>d
                  </span>
                </td>
                <td style="max-width:200px;">
                  <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--text2);font-size:0.82rem;">
                    <%= lr.getReason() != null ? lr.getReason() : "—" %>
                  </div>
                </td>
                <td style="color:var(--text3);font-size:0.78rem;">
                  <%= lr.getAppliedOn() != null ? lr.getAppliedOn().toString().substring(0,10) : "N/A" %>
                </td>
                <td>
                  <span class="badge badge-<%= statusClass %>">
                    <%= "APPROVED".equals(lr.getStatus()) ? "✓" : "REJECTED".equals(lr.getStatus()) ? "✗" : "●" %> <%= lr.getStatus() %>
                  </span>
                </td>
                <td>
                  <% if (!actioned) { %>
                  <div style="display:flex;gap:8px;align-items:center;">
                    <form action="approveLeave" method="post" style="display:inline;">
                      <input type="hidden" name="leaveId" value="<%= lr.getLeaveId() %>"/>
                      <button type="button" class="btn-success btn-sm confirm-approve" title="Approve">✓ Approve</button>
                    </form>
                    <form action="rejectLeave" method="post" style="display:inline;">
                      <input type="hidden" name="leaveId" value="<%= lr.getLeaveId() %>"/>
                      <button type="button" class="btn-danger btn-sm confirm-reject" title="Reject">✗ Reject</button>
                    </form>
                  </div>
                  <% } else { %>
                  <span style="font-size:0.78rem;color:var(--text3);font-style:italic;">No action needed</span>
                  <% } %>
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

  <!-- ── CONFIRM MODAL ── -->
  <div id="confirm-modal">
    <div class="modal-box">
      <span class="modal-icon">⚠️</span>
      <div class="modal-title" id="modal-title">Are you sure?</div>
      <div class="modal-msg" id="modal-msg">This action cannot be undone.</div>
      <div class="modal-actions">
        <button class="btn-ghost btn-sm" id="modal-no">Cancel</button>
        <button class="btn-primary btn-sm" id="modal-yes">Confirm</button>
      </div>
    </div>
  </div>

  <div id="toast"></div>
  <script src="js/interactions.js"></script>
  <script>
    function exportCSV() {
      var table = document.getElementById('admin-table');
      if (!table) return;
      var rows = table.querySelectorAll('tr');
      var csv = [];
      rows.forEach(function(row) {
        var cols = row.querySelectorAll('th, td');
        var line = [];
        cols.forEach(function(col) {
          var text = col.textContent.replace(/\s+/g, ' ').trim().replace(/,/g, ';');
          line.push('"' + text + '"');
        });
        csv.push(line.join(','));
      });
      var blob = new Blob([csv.join('\n')], { type: 'text/csv' });
      var url = URL.createObjectURL(blob);
      var a = document.createElement('a');
      a.href = url; a.download = 'leave_requests.csv'; a.click();
      URL.revokeObjectURL(url);
    }
  </script>
</body>
</html>
