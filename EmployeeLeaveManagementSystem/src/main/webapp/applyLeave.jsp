<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Employee" %>
<%
    Employee emp = (Employee) session.getAttribute("employee");
    if (emp == null) { response.sendRedirect("login"); return; }
    String initials = emp.getName().length() >= 2
        ? emp.getName().substring(0,2).toUpperCase()
        : emp.getName().toUpperCase();
    String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Apply Leave — LeaveOS</title>
  <meta name="description" content="Apply for employee leave — LeaveOS"/>
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
      <a href="dashboard" class="nav-link">
        <span class="nav-icon">🏠</span> Dashboard
      </a>
      <a href="applyLeave" class="nav-link active">
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
        <div class="page-title">Apply Leave</div>
        <div class="breadcrumb">Home / <span>Apply Leave</span></div>
      </div>
      <div class="header-right">
        <div id="live-clock"></div>
        <div class="header-avatar"><%= initials %></div>
      </div>
    </header>

    <div class="content-area">
      <div class="apply-grid">
        <!-- ── LEFT: FORM ── -->
        <div class="glass-card" style="padding:32px;">
          <div style="margin-bottom:24px;">
            <div class="section-title" style="font-size:1.3rem;">📝 Leave Application</div>
            <div style="font-size:0.83rem;color:var(--text3);margin-top:6px;">Fill the form below to submit your leave request</div>
          </div>

          <!-- Step Indicator -->
          <div class="step-indicator">
            <div class="step-dot active">1</div>
            <div class="step-line"></div>
            <div class="step-dot active">2</div>
            <div class="step-line"></div>
            <div class="step-dot active">3</div>
            <span style="font-size:0.75rem;color:var(--text3);margin-left:8px;">Date → Reason → Confirm</span>
          </div>

          <!-- Error message -->
          <% if (request.getAttribute("error") != null) { %>
          <div class="alert-error"><span>⚠️</span> <%= request.getAttribute("error") %></div>
          <% } %>

          <form action="applyLeave" method="post" id="apply-form">
            <!-- Leave Type Pills -->
            <div style="margin-bottom:20px;">
              <label style="font-size:0.82rem;color:var(--text3);display:block;margin-bottom:10px;">Leave Type</label>
              <div class="leave-type-grid">
                <button type="button" class="leave-type-pill selected" data-type="Annual">🌴 Annual</button>
                <button type="button" class="leave-type-pill" data-type="Sick">🤒 Sick</button>
                <button type="button" class="leave-type-pill" data-type="Emergency">🚨 Emergency</button>
                <button type="button" class="leave-type-pill" data-type="Personal">🧘 Personal</button>
              </div>
              <input type="hidden" name="leaveType" id="leaveType" value="Annual"/>
            </div>

            <!-- Date Row -->
            <div class="date-row" style="margin-bottom:8px;">
              <div class="input-group">
                <input type="date" name="fromDate" id="fromDate" class="form-input" placeholder=" " required min="<%= today %>"/>
                <label for="fromDate">From Date</label>
              </div>
              <div class="input-group">
                <input type="date" name="toDate" id="toDate" class="form-input" placeholder=" " required min="<%= today %>"/>
                <label for="toDate">To Date</label>
              </div>
            </div>
            <div id="duration-display" class="duration-chip" style="display:none;margin-bottom:20px;">📅 Duration: --</div>

            <!-- Reason Textarea -->
            <div style="margin-bottom:6px;">
              <label style="font-size:0.82rem;color:var(--text3);display:block;margin-bottom:8px;">Reason for Leave</label>
              <textarea name="reason" id="reason" class="form-input" rows="5"
                        placeholder="Describe the reason for your leave request..."
                        maxlength="500" style="resize:vertical;"></textarea>
            </div>
            <div class="char-count"><span id="char-count">0 / 500</span></div>

            <div style="margin-top:24px;">
              <button type="submit" class="btn-primary magnetic" style="width:100%;justify-content:center;padding:14px 20px;" id="submit-btn">
                <span class="btn-text">🚀 Submit Leave Request</span>
                <span class="spinner"></span>
              </button>
            </div>
          </form>
        </div>

        <!-- ── RIGHT: DECORATIVE PANEL ── -->
        <div style="display:flex;flex-direction:column;gap:20px;">
          <!-- Mini Calendar -->
          <div class="glass-card mini-calendar" id="mini-cal-card">
            <div class="cal-header">
              <span>📅 <span id="cal-month-year"></span></span>
            </div>
            <div class="cal-grid" id="cal-grid"></div>
          </div>

          <!-- Leave Balance -->
          <div class="glass-card" style="padding:22px;">
            <div style="font-size:0.88rem;font-weight:600;margin-bottom:14px;color:var(--text2);">📊 Leave Balance</div>
            <div class="balance-cards">
              <div class="balance-card">
                <div class="balance-label">🌴 Annual</div>
                <div class="balance-count" style="color:var(--violet-light);">18 <span style="font-size:0.7rem;color:var(--text3);">days</span></div>
              </div>
              <div class="balance-card">
                <div class="balance-label">🤒 Sick</div>
                <div class="balance-count" style="color:var(--cyan-light);">10 <span style="font-size:0.7rem;color:var(--text3);">days</span></div>
              </div>
              <div class="balance-card">
                <div class="balance-label">🚨 Emergency</div>
                <div class="balance-count" style="color:var(--amber);">3 <span style="font-size:0.7rem;color:var(--text3);">days</span></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>

  <div id="toast"></div>
  <script src="js/interactions.js"></script>
  <script>
    // Build mini calendar
    (function() {
      var now = new Date();
      var year = now.getFullYear();
      var month = now.getMonth();
      var today = now.getDate();
      var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
      document.getElementById('cal-month-year').textContent = months[month] + ' ' + year;

      var grid = document.getElementById('cal-grid');
      var dayNames = ['Su','Mo','Tu','We','Th','Fr','Sa'];
      dayNames.forEach(function(d) {
        var el = document.createElement('div');
        el.className = 'cal-day-name'; el.textContent = d;
        grid.appendChild(el);
      });

      var firstDay = new Date(year, month, 1).getDay();
      var daysInMonth = new Date(year, month + 1, 0).getDate();

      for (var i = 0; i < firstDay; i++) {
        var empty = document.createElement('div');
        empty.className = 'cal-day empty'; grid.appendChild(empty);
      }
      for (var d = 1; d <= daysInMonth; d++) {
        var el = document.createElement('div');
        el.className = 'cal-day' + (d === today ? ' today' : '');
        el.textContent = d;
        grid.appendChild(el);
      }
    })();
  </script>
</body>
</html>
