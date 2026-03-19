<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Employee, model.LeaveRequest, java.util.List" %>
<%
    Employee emp = (Employee) session.getAttribute("employee");
    if (emp == null) { response.sendRedirect("login"); return; }
    List<LeaveRequest> leaves = (List<LeaveRequest>) request.getAttribute("leaves");
    Long totalLeaves = (Long) request.getAttribute("totalLeaves");
    Long pendingCount = (Long) request.getAttribute("pendingCount");
    Long approvedCount = (Long) request.getAttribute("approvedCount");
    Long rejectedCount = (Long) request.getAttribute("rejectedCount");
    if (totalLeaves == null) totalLeaves = 0L;
    if (pendingCount == null) pendingCount = 0L;
    if (approvedCount == null) approvedCount = 0L;
    if (rejectedCount == null) rejectedCount = 0L;
    String initials = emp.getName().length() >= 2
        ? emp.getName().substring(0,2).toUpperCase()
        : emp.getName().toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Dashboard — LeaveOS</title>
  <meta name="description" content="Employee leave dashboard — track your leave applications"/>
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
      <div class="nav-label">Navigation</div>
      <a href="dashboard" class="nav-link active">
        <span class="nav-icon">🏠</span> Dashboard
      </a>
      <a href="applyLeave" class="nav-link">
        <span class="nav-icon">📝</span> Apply Leave
      </a>
      <a href="viewLeaves" class="nav-link">
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
        <span class="role-badge <%= "ADMIN".equals(emp.getRole()) ? "role-admin" : "role-employee" %>">
          <%= emp.getRole() %>
        </span>
      </div>
      <a href="logout" class="btn-logout">🚪 Sign Out</a>
    </div>
  </aside>

  <!-- ── MAIN CONTENT ── -->
  <main class="main-content">
    <!-- Top Header -->
    <header class="top-header">
      <div>
        <button class="hamburger" id="hamburger">☰</button>
        <div class="page-title">Dashboard</div>
        <div class="breadcrumb">Home / <span>Dashboard</span></div>
      </div>
      <div class="header-right">
        <div id="live-clock"></div>
        <button class="notif-bell" title="Notifications">
          🔔 <span class="notif-dot"></span>
        </button>
        <div class="header-avatar" title="<%= emp.getName() %>"><%= initials %></div>
      </div>
    </header>

    <div class="content-area">
      <!-- ── STATS ROW ── -->
      <div class="stats-grid">
        <!-- Total Applied -->
        <div class="glass-card stat-card tilt-card">
          <div class="stat-icon-box" style="background:rgba(124,58,237,0.15);">📊</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#a78bfa,#fff);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= totalLeaves %>
          </div>
          <div class="stat-label">Total Applied</div>
          <div class="stat-trend trend-up">↑ All requests</div>
          <div class="sparkline" style="color:var(--violet);">
            <div class="spark-bar" style="height:40%;"></div>
            <div class="spark-bar" style="height:60%;"></div>
            <div class="spark-bar" style="height:80%;"></div>
            <div class="spark-bar" style="height:50%;"></div>
            <div class="spark-bar active" style="height:100%;"></div>
          </div>
        </div>

        <!-- Approved -->
        <div class="glass-card stat-card tilt-card">
          <div class="stat-icon-box" style="background:rgba(16,185,129,0.15);">✅</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#6ee7b7,#10b981);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= approvedCount %>
          </div>
          <div class="stat-label">Approved</div>
          <div class="stat-trend trend-up">↑ Approved leaves</div>
          <div class="sparkline" style="color:var(--green);">
            <div class="spark-bar" style="height:30%;"></div>
            <div class="spark-bar" style="height:55%;"></div>
            <div class="spark-bar" style="height:70%;"></div>
            <div class="spark-bar" style="height:60%;"></div>
            <div class="spark-bar active" style="height:90%;"></div>
          </div>
        </div>

        <!-- Pending -->
        <div class="glass-card stat-card tilt-card">
          <div class="stat-icon-box" style="background:rgba(245,158,11,0.15);">⏳</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#fcd34d,#f59e0b);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= pendingCount %>
          </div>
          <div class="stat-label">Pending</div>
          <div class="stat-trend" style="color:var(--amber);">● Awaiting decision</div>
          <div class="sparkline" style="color:var(--amber);">
            <div class="spark-bar" style="height:50%;"></div>
            <div class="spark-bar" style="height:80%;"></div>
            <div class="spark-bar" style="height:40%;"></div>
            <div class="spark-bar" style="height:70%;"></div>
            <div class="spark-bar active" style="height:60%;"></div>
          </div>
        </div>

        <!-- Rejected -->
        <div class="glass-card stat-card tilt-card">
          <div class="stat-icon-box" style="background:rgba(244,63,94,0.12);">❌</div>
          <div class="stat-number" style="background:linear-gradient(135deg,#fda4af,#f43f5e);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">
            <%= rejectedCount %>
          </div>
          <div class="stat-label">Rejected</div>
          <div class="stat-trend trend-down">↓ Declined requests</div>
          <div class="sparkline" style="color:var(--pink);">
            <div class="spark-bar" style="height:70%;"></div>
            <div class="spark-bar" style="height:40%;"></div>
            <div class="spark-bar" style="height:60%;"></div>
            <div class="spark-bar" style="height:30%;"></div>
            <div class="spark-bar active" style="height:50%;"></div>
          </div>
        </div>
      </div>

      <!-- ── BOTTOM ROW: Activity + Quick Apply ── -->
      <div style="display:grid;grid-template-columns:1fr 340px;gap:24px;">

        <!-- Recent Activity -->
        <div class="glass-card" style="padding:28px;">
          <div class="section-header">
            <div class="section-title">📅 Recent Activity</div>
            <a href="viewLeaves" class="section-link">View All →</a>
          </div>

          <% if (leaves == null || leaves.isEmpty()) { %>
          <div style="text-align:center;padding:48px 0;color:var(--text3);">
            <div style="font-size:3rem;margin-bottom:16px;">📭</div>
            <div style="font-size:0.9rem;">No leave requests yet.</div>
            <a href="applyLeave" class="link-text" style="font-size:0.85rem;margin-top:8px;display:inline-block;">Apply for leave →</a>
          </div>
          <% } else { %>
          <div class="timeline">
            <% int count = 0; for (LeaveRequest lr : leaves) { if (count++ >= 5) break;
               String dotColor = "APPROVED".equals(lr.getStatus()) ? "var(--green)"
                               : "REJECTED".equals(lr.getStatus()) ? "var(--pink)" : "var(--amber)";
               String statusClass = lr.getStatus().toLowerCase();
            %>
            <div class="timeline-item">
              <div class="timeline-dot-wrap">
                <div class="timeline-dot" style="color:<%= dotColor %>;border-color:<%= dotColor %>;background:<%= dotColor %>22;"></div>
                <% if (count < Math.min(leaves.size(), 5)) { %><div class="timeline-line"></div><% } %>
              </div>
              <div class="timeline-content">
                <div class="timeline-meta">Applied on <%= lr.getAppliedOn() != null ? lr.getAppliedOn().toString().substring(0,10) : "N/A" %></div>
                <div class="timeline-dates"><%= lr.getFromDate() %> → <%= lr.getToDate() %></div>
                <div class="timeline-reason"><%= lr.getReason() != null ? lr.getReason() : "No reason provided" %></div>
              </div>
              <span class="badge badge-<%= statusClass %>"><%= lr.getStatus() %></span>
            </div>
            <% } %>
          </div>
          <% } %>
        </div>

        <!-- Quick Apply Widget -->
        <div class="glass-card quick-apply">
          <div class="quick-apply-title">⚡ Quick Apply</div>
          <form action="applyLeave" method="post">
            <div class="input-group" style="margin-bottom:14px;">
              <input type="date" name="fromDate" class="form-input" placeholder=" " required
                     style="padding:12px 14px;font-size:0.85rem;" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"/>
              <label style="font-size:0.78rem;top:10px;">From Date</label>
            </div>
            <div class="input-group" style="margin-bottom:14px;">
              <input type="date" name="toDate" class="form-input" placeholder=" " required
                     style="padding:12px 14px;font-size:0.85rem;" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"/>
              <label style="font-size:0.78rem;top:10px;">To Date</label>
            </div>
            <div class="input-group" style="margin-bottom:16px;">
              <textarea name="reason" class="form-input" rows="3" placeholder="Reason for leave..."
                        style="padding:12px 14px;font-size:0.85rem;resize:none;"></textarea>
            </div>
            <button type="submit" class="btn-primary" style="width:100%;justify-content:center;padding:11px 20px;">
              Submit Request
            </button>
          </form>

          <!-- Leave Balance donut -->
          <div style="margin-top:20px;padding-top:16px;border-top:1px solid var(--border);">
            <div style="font-size:0.8rem;font-weight:600;color:var(--text2);margin-bottom:10px;">Leave Balance</div>
            <div class="donut-wrap">
              <div class="donut" style="background:conic-gradient(var(--violet) 0% 65%, rgba(255,255,255,0.06) 65% 100%);">
                <div style="background:var(--surface);width:36px;height:36px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:0.65rem;font-weight:700;color:var(--violet-light);">65%</div>
              </div>
              <div>
                <div style="font-size:0.82rem;font-weight:600;color:var(--text);">13 days left</div>
                <div style="font-size:0.73rem;color:var(--text3);">of 20 annual days</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>

  <div id="toast"></div>
  <script src="js/interactions.js"></script>
</body>
</html>
