<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Sign In — LeaveOS</title>
  <meta name="description" content="Sign in to LeaveOS Employee Leave Management System"/>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Syne:wght@600;700;800&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
  <!-- Background layers -->
  <div class="bg-dot-grid"></div>
  <div class="bg-diagonal"></div>
  <div class="orb orb-a"></div>
  <div class="orb orb-b"></div>
  <div class="orb orb-c"></div>
  <div class="orb orb-d"></div>
  <div id="scroll-progress"></div>

  <div class="split-layout" style="position:relative;z-index:1;">
    <!-- ── LEFT ART PANEL ── -->
    <div class="split-left">
      <div class="scanline-wrap"><div class="scanline"></div></div>
      <div class="art-rings">
        <div class="ring ring-1"></div>
        <div class="ring ring-2"></div>
        <div class="ring ring-3"></div>
        <div style="position:relative;z-index:1;text-align:center;">
          <div style="font-size:2.5rem;animation:float 4s ease-in-out infinite;">🚀</div>
        </div>
      </div>

      <div style="position:relative;z-index:1;max-width:440px;">
        <div class="art-panel-heading">LeaveOS</div>
        <p class="art-sub">The next-generation employee leave management platform. Streamlined, transparent, and built for modern teams.</p>
        <div class="feature-bullets">
          <div class="feature-bullet">
            <div class="bullet-dot"></div>
            <span class="bullet-text">Apply and track leaves in real-time</span>
          </div>
          <div class="feature-bullet">
            <div class="bullet-dot" style="background:var(--cyan);box-shadow:0 0 12px var(--cyan);"></div>
            <span class="bullet-text">Instant admin approvals with full history</span>
          </div>
          <div class="feature-bullet">
            <div class="bullet-dot" style="background:var(--green);box-shadow:0 0 12px var(--green);"></div>
            <span class="bullet-text">Role-based access — employee & admin views</span>
          </div>
        </div>
      </div>

      <div class="hud-element">
        <div class="hud-line">SYS: <span class="hud-accent">LEAVEOS v2.0</span></div>
        <div class="hud-line">STATUS: <span class="hud-accent">ONLINE</span></div>
        <div class="hud-line">COORD: <span class="hud-accent">12.9716° N, 77.5946° E</span></div>
        <div class="hud-line">UPTIME: <span class="hud-accent" id="hud-uptime">--:--:--</span></div>
      </div>
    </div>

    <!-- ── RIGHT FORM ── -->
    <div class="split-right">
      <div class="form-box">
        <div class="form-logo">
          <div class="form-logo-icon">🛡️</div>
          <div>
            <div style="font-family:'Syne',sans-serif;font-size:1.1rem;font-weight:700;">LeaveOS</div>
            <div style="font-size:0.72rem;color:var(--text3);">Management System</div>
          </div>
        </div>

        <div class="form-heading">Welcome Back</div>
        <p class="form-subtext">Sign in to your workspace to continue</p>

        <!-- Error alert -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error">
          <span>⚠️</span>
          <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <!-- Success toast will auto-fire via JS param check -->

        <form action="login" method="post" id="login-form">
          <div class="input-group">
            <input type="email" name="email" id="email" class="form-input" placeholder=" " required autocomplete="email"/>
            <label for="email">Email address</label>
          </div>

          <div class="input-group">
            <input type="password" name="password" id="pwd-field" class="form-input" placeholder=" " required autocomplete="current-password"/>
            <label for="pwd-field">Password</label>
          </div>

          <div style="text-align:right;margin-bottom:24px;margin-top:-8px;">
            <a href="#" class="link-text" style="font-size:0.82rem;">Forgot password?</a>
          </div>

          <button type="submit" class="btn-primary magnetic w-full" id="login-btn" style="width:100%;justify-content:center;">
            <span class="btn-text">Sign In →</span>
            <span class="spinner"></span>
          </button>
        </form>

        <div class="divider"><div class="divider-line"></div><span class="divider-text">NEW HERE?</span><div class="divider-line"></div></div>

        <div style="text-align:center;font-size:0.88rem;color:var(--text2);">
          Don't have an account? <a href="register" class="link-text">Create one</a>
        </div>

        <div class="secure-badge">
          <span class="secure-icon">🔒</span>
          <span>Secured by 256-bit AES encryption</span>
        </div>
      </div>
    </div>
  </div>

  <!-- Toast -->
  <div id="toast"></div>

  <script src="js/interactions.js"></script>
  <script>
    // HUD uptime counter
    var startTime = Date.now();
    setInterval(function () {
      var elapsed = Math.floor((Date.now() - startTime) / 1000);
      var h = String(Math.floor(elapsed / 3600)).padStart(2, '0');
      var m = String(Math.floor((elapsed % 3600) / 60)).padStart(2, '0');
      var s = String(elapsed % 60).padStart(2, '0');
      var el = document.getElementById('hud-uptime');
      if (el) el.textContent = h + ':' + m + ':' + s;
    }, 1000);
  </script>
</body>
</html>
