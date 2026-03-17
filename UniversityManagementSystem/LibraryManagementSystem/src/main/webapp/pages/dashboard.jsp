<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bibliox.model.*,java.util.*" %>
<%
  List<IssuedBook> activity = (List<IssuedBook>) request.getAttribute("recentActivity");
  String stats = (String) request.getAttribute("stats");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>BiblioX — Dashboard</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"/>
</head>
<body>

<%@ include file="layout-top.jsp" %>

<div class="content">
  <div class="page-header fade-up">
    <div class="page-title">DASH<span>BOARD</span></div>
    <div class="page-sub">Overview · Live Stats</div>
  </div>

  <!-- STATS -->
  <div class="stats-grid" id="stats-grid">
    <div class="stat-card accent fade-up">
      <div class="stat-label">Total Books</div>
      <div class="stat-value" id="stat-books">—</div>
      <div class="stat-trend up">↑ In catalogue</div>
    </div>
    <div class="stat-card danger fade-up">
      <div class="stat-label">Issued Books</div>
      <div class="stat-value" id="stat-issued">—</div>
      <div class="stat-trend">Currently out</div>
    </div>
    <div class="stat-card success fade-up">
      <div class="stat-label">Total Members</div>
      <div class="stat-value" id="stat-members">—</div>
      <div class="stat-trend up">↑ Registered</div>
    </div>
    <div class="stat-card warn fade-up">
      <div class="stat-label">Overdue</div>
      <div class="stat-value" id="stat-overdue">—</div>
      <div class="stat-trend down">↓ Needs action</div>
    </div>
  </div>

  <!-- LOWER GRID -->
  <div class="grid-2">
    <!-- RECENT ACTIVITY -->
    <div class="panel fade-up">
      <div class="panel-head">
        <div class="panel-title">
          <div class="panel-dot" style="background:var(--accent);box-shadow:0 0 6px var(--accent)"></div>
          Recent Activity
        </div>
        <div class="panel-badge">Live</div>
      </div>
      <div class="panel-body">
        <% if (activity == null || activity.isEmpty()) { %>
        <div class="empty-state">
          <div class="empty-state-icon">📭</div>
          <div class="empty-state-text">No activity yet</div>
        </div>
        <% } else {
          for (IssuedBook ib : activity) {
            String dotColor = ib.getStatus() == IssueStatus.OVERDUE ? "var(--danger)"
                            : ib.getStatus() == IssueStatus.RETURNED ? "var(--muted)"
                            : "var(--success)";
        %>
        <div class="activity-item">
          <div class="act-line">
            <div class="act-dot" style="background:<%=dotColor%>"></div>
            <div class="act-connector"></div>
          </div>
          <div class="act-body">
            <div class="act-text">
              <b><%=ib.getUser().getName()%></b>
              <%= ib.getStatus() == IssueStatus.RETURNED ? "returned" : "issued" %>
              <b><%=ib.getBook().getTitle()%></b>
            </div>
            <div class="act-time"><%=ib.getIssuedDate() != null ? ib.getIssuedDate().toLocalDate() : ""%></div>
          </div>
        </div>
        <% } } %>
      </div>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="panel fade-up">
      <div class="panel-head">
        <div class="panel-title">
          <div class="panel-dot" style="background:var(--success)"></div>
          Quick Actions
        </div>
      </div>
      <div class="panel-body" style="padding:20px;display:flex;flex-direction:column;gap:12px;">
        <a href="<%=request.getContextPath()%>/books" class="btn btn-outline" style="justify-content:space-between;">
          📚 View All Books <span>→</span>
        </a>
        <a href="<%=request.getContextPath()%>/members" class="btn btn-outline" style="justify-content:space-between;">
          👥 Manage Members <span>→</span>
        </a>
        <a href="<%=request.getContextPath()%>/issue" class="btn btn-accent" style="justify-content:space-between;">
          ↕ Issue / Return Book <span>→</span>
        </a>
        <div style="height:0.5px;background:var(--border);margin:4px 0"></div>
        <div style="font-family:var(--font-mono);font-size:10px;color:var(--muted);text-transform:uppercase;letter-spacing:1px">
          Default Credentials
        </div>
        <div style="font-family:var(--font-mono);font-size:11px;color:var(--muted);line-height:1.9">
          superadmin@bibliox.com / admin123<br/>
          admin@bibliox.com / admin123<br/>
          student@bibliox.com / student123
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="layout-bottom.jsp" %>

<script>
  const stats = <%=stats != null ? stats : "{}" %>;
  function animateCount(el, target) {
    if (!el) return;
    let c = 0, step = Math.max(1, Math.floor(target / 40));
    const t = setInterval(() => {
      c = Math.min(c + step, target);
      el.textContent = c.toLocaleString();
      if (c >= target) clearInterval(t);
    }, 20);
  }
  animateCount(document.getElementById('stat-books'), stats.totalBooks || 0);
  animateCount(document.getElementById('stat-issued'), stats.issuedBooks || 0);
  animateCount(document.getElementById('stat-members'), stats.totalMembers || 0);
  animateCount(document.getElementById('stat-overdue'), stats.overdueBooks || 0);
</script>
