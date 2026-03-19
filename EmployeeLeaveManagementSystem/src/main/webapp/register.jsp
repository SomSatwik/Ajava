<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Register — LeaveOS</title>
  <meta name="description" content="Create your LeaveOS employee account"/>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Syne:wght@600;700;800&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
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
          <div style="font-size:2.5rem;animation:float 5s ease-in-out infinite;">🌐</div>
        </div>
      </div>

      <div style="position:relative;z-index:1;max-width:440px;">
        <div class="art-panel-heading" style="font-size:2.6rem;">Join LeaveOS</div>
        <p class="art-sub">Set up your employee account and start managing leaves the smart way. Takes less than 60 seconds.</p>
        <div class="feature-bullets">
          <div class="feature-bullet">
            <div class="bullet-dot"></div>
            <span class="bullet-text">Free employee account, no credit card needed</span>
          </div>
          <div class="feature-bullet">
            <div class="bullet-dot" style="background:var(--cyan);box-shadow:0 0 12px var(--cyan);"></div>
            <span class="bullet-text">Instant access to leave dashboard</span>
          </div>
          <div class="feature-bullet">
            <div class="bullet-dot" style="background:var(--amber);box-shadow:0 0 12px var(--amber);"></div>
            <span class="bullet-text">Track approvals in real-time</span>
          </div>
        </div>
      </div>

      <div class="hud-element">
        <div class="hud-line">MODULE: <span class="hud-accent">REGISTRATION</span></div>
        <div class="hud-line">ENCRYPT: <span class="hud-accent">AES-256</span></div>
        <div class="hud-line">MODE: <span class="hud-accent">EMPLOYEE ONBOARDING</span></div>
      </div>
    </div>

    <!-- ── RIGHT FORM ── -->
    <div class="split-right">
      <div class="form-box">
        <div class="form-logo">
          <div class="form-logo-icon">✨</div>
          <div>
            <div style="font-family:'Syne',sans-serif;font-size:1.1rem;font-weight:700;">LeaveOS</div>
            <div style="font-size:0.72rem;color:var(--text3);">Create Account</div>
          </div>
        </div>

        <div class="form-heading">Get Started</div>
        <p class="form-subtext">Create your employee account in seconds</p>

        <!-- Error alert -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error">
          <span>⚠️</span>
          <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="register" method="post" id="register-form">
          <div class="input-group">
            <input type="text" name="name" id="name" class="form-input" placeholder=" " required autocomplete="name"/>
            <label for="name">Full name</label>
          </div>

          <div class="input-group">
            <input type="email" name="email" id="reg-email" class="form-input" placeholder=" " required autocomplete="email"/>
            <label for="reg-email">Email address</label>
          </div>

          <div class="input-group" style="margin-bottom:8px;">
            <input type="password" name="password" id="password" class="form-input" placeholder=" " required autocomplete="new-password"/>
            <label for="password">Password</label>
          </div>
          <!-- Password Strength Meter -->
          <div class="strength-bar-wrap" style="margin-bottom:20px;">
            <div class="strength-bar" id="strength-bar"></div>
          </div>

          <div class="input-group">
            <input type="password" name="confirmPassword" id="confirm-pwd" class="form-input" placeholder=" " required autocomplete="new-password"/>
            <label for="confirm-pwd">Confirm password</label>
          </div>

          <div style="margin-bottom:24px;">
            <label style="font-size:0.82rem;color:var(--text3);display:block;margin-bottom:8px;">Role</label>
            <select name="role" class="form-input" style="cursor:pointer;">
              <option value="EMPLOYEE">Employee</option>
              <option value="ADMIN">Admin</option>
            </select>
          </div>

          <button type="submit" class="btn-primary magnetic w-full" style="width:100%;justify-content:center;" id="reg-btn">
            <span class="btn-text">Create Account →</span>
            <span class="spinner"></span>
          </button>
        </form>

        <div class="divider"><div class="divider-line"></div><span class="divider-text">EXISTING USER?</span><div class="divider-line"></div></div>

        <div style="text-align:center;font-size:0.88rem;color:var(--text2);">
          Already have an account? <a href="login" class="link-text">Sign in</a>
        </div>

        <div class="secure-badge">
          <span class="secure-icon">🔒</span>
          <span>Your data is protected with 256-bit encryption</span>
        </div>
      </div>
    </div>
  </div>

  <div id="toast"></div>

  <script src="js/interactions.js"></script>
  <script>
    // Confirm password match check
    document.getElementById('register-form').addEventListener('submit', function(e) {
      var p1 = document.getElementById('password').value;
      var p2 = document.getElementById('confirm-pwd').value;
      if (p1 !== p2) {
        e.preventDefault();
        var existing = document.querySelector('.alert-error');
        if (existing) existing.remove();
        var alert = document.createElement('div');
        alert.className = 'alert-error';
        alert.innerHTML = '<span>⚠️</span> Passwords do not match';
        document.getElementById('register-form').prepend(alert);
        document.getElementById('reg-btn').classList.remove('loading');
      }
    });
  </script>
</body>
</html>
