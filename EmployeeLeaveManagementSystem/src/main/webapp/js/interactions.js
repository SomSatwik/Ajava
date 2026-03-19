/* ============================================================
   INTERACTIONS.JS — Employee Leave Management System
   Custom Cursor · Magnetic Buttons · 3D Tilt · Ripple
   Stagger Fade-Up · Live Clock · Duration Calc · Char Counter
   Password Strength · Table Filters · Confirm Modals · Toasts
   Sidebar Toggle · Scroll Progress
   ============================================================ */

document.addEventListener('DOMContentLoaded', function () {

  // ── 1. CUSTOM CURSOR ──────────────────────────────────────
  const cursorOuter = document.createElement('div');
  cursorOuter.id = 'cursor-outer';
  const cursorInner = document.createElement('div');
  cursorInner.id = 'cursor-inner';
  document.body.appendChild(cursorOuter);
  document.body.appendChild(cursorInner);

  let mouseX = 0, mouseY = 0;
  let outerX = 0, outerY = 0;

  document.addEventListener('mousemove', function (e) {
    mouseX = e.clientX;
    mouseY = e.clientY;
    cursorInner.style.left = mouseX + 'px';
    cursorInner.style.top = mouseY + 'px';
  });

  function lerpCursor() {
    outerX += (mouseX - outerX) * 0.12;
    outerY += (mouseY - outerY) * 0.12;
    cursorOuter.style.left = outerX + 'px';
    cursorOuter.style.top = outerY + 'px';
    requestAnimationFrame(lerpCursor);
  }
  lerpCursor();

  document.querySelectorAll('a, button, .glass-card, .nav-link, .filter-pill, .leave-type-pill').forEach(function (el) {
    el.addEventListener('mouseenter', function () { cursorOuter.classList.add('hovered'); });
    el.addEventListener('mouseleave', function () { cursorOuter.classList.remove('hovered'); });
  });


  // ── 2. MAGNETIC BUTTONS ──────────────────────────────────
  document.querySelectorAll('.magnetic').forEach(function (btn) {
    btn.addEventListener('mousemove', function (e) {
      const rect = btn.getBoundingClientRect();
      const dx = e.clientX - (rect.left + rect.width / 2);
      const dy = e.clientY - (rect.top + rect.height / 2);
      btn.style.transform = 'translate(' + dx * 0.25 + 'px, ' + dy * 0.25 + 'px)';
    });
    btn.addEventListener('mouseleave', function () {
      btn.style.transform = '';
    });
  });


  // ── 3. 3D CARD TILT ──────────────────────────────────────
  document.querySelectorAll('.tilt-card').forEach(function (card) {
    card.addEventListener('mousemove', function (e) {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      const cx = rect.width / 2;
      const cy = rect.height / 2;
      const rotX = ((y - cy) / cy) * -8;
      const rotY = ((x - cx) / cx) * 8;
      card.style.transform = 'perspective(1000px) rotateX(' + rotX + 'deg) rotateY(' + rotY + 'deg) translateY(-4px)';
    });
    card.addEventListener('mouseleave', function () {
      card.style.transition = 'transform 0.5s ease';
      card.style.transform = '';
      setTimeout(function () { card.style.transition = ''; }, 500);
    });
  });


  // ── 4. CLICK RIPPLE ──────────────────────────────────────
  document.querySelectorAll('.btn-primary').forEach(function (btn) {
    btn.addEventListener('click', function (e) {
      const rect = btn.getBoundingClientRect();
      const x = ((e.clientX - rect.left) / rect.width * 100).toFixed(1);
      const y = ((e.clientY - rect.top) / rect.height * 100).toFixed(1);
      btn.style.setProperty('--x', x + '%');
      btn.style.setProperty('--y', y + '%');

      const ripple = document.createElement('span');
      ripple.style.cssText = [
        'position:absolute', 'border-radius:50%', 'pointer-events:none',
        'width:10px', 'height:10px',
        'left:' + (e.clientX - rect.left - 5) + 'px',
        'top:' + (e.clientY - rect.top - 5) + 'px',
        'background:rgba(255,255,255,0.4)',
        'transform:scale(0)', 'animation:rippleOut 0.6s ease forwards'
      ].join(';');
      btn.appendChild(ripple);
      setTimeout(function () { ripple.remove(); }, 700);
    });
  });


  // ── 5. STAGGER FADE-UP ──────────────────────────────────
  var animEls = document.querySelectorAll('.stat-card, .glass-card, .card, .timeline-item');
  animEls.forEach(function (el, i) {
    if (!el.style.animationDelay) {
      el.style.animationDelay = (i * 0.08) + 's';
      el.classList.add('fade-up');
    }
  });


  // ── 6. LIVE CLOCK ────────────────────────────────────────
  var clockEl = document.getElementById('live-clock');
  if (clockEl) {
    function updateClock() {
      var now = new Date();
      var days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
      var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      var d = days[now.getDay()];
      var dd = String(now.getDate()).padStart(2, '0');
      var m = months[now.getMonth()];
      var y = now.getFullYear();
      var hh = String(now.getHours()).padStart(2, '0');
      var mm = String(now.getMinutes()).padStart(2, '0');
      var ss = String(now.getSeconds()).padStart(2, '0');
      clockEl.textContent = d + ', ' + dd + ' ' + m + ' ' + y + ' · ' + hh + ':' + mm + ':' + ss;
    }
    updateClock();
    setInterval(updateClock, 1000);
  }


  // ── 7. LEAVE DURATION CALCULATOR ─────────────────────────
  var fromInput = document.getElementById('fromDate');
  var toInput = document.getElementById('toDate');
  var durationDisplay = document.getElementById('duration-display');

  function calcDuration() {
    if (fromInput && toInput && fromInput.value && toInput.value) {
      var from = new Date(fromInput.value);
      var to = new Date(toInput.value);
      if (to >= from) {
        var ms = to - from;
        var days = Math.floor(ms / (1000 * 60 * 60 * 24)) + 1;
        if (durationDisplay) {
          durationDisplay.textContent = '📅 Duration: ' + days + ' working day' + (days !== 1 ? 's' : '');
          durationDisplay.style.display = 'inline-flex';
        }
      } else {
        if (durationDisplay) durationDisplay.textContent = '⚠️ End date before start date';
      }
    }
  }

  if (fromInput) fromInput.addEventListener('change', calcDuration);
  if (toInput) toInput.addEventListener('change', calcDuration);


  // ── 8. TEXTAREA CHARACTER COUNTER ────────────────────────
  var reasonArea = document.getElementById('reason');
  var charCountEl = document.getElementById('char-count');
  if (reasonArea && charCountEl) {
    reasonArea.addEventListener('input', function () {
      charCountEl.textContent = reasonArea.value.length + ' / 500';
      if (reasonArea.value.length > 500) {
        charCountEl.style.color = 'var(--pink)';
      } else {
        charCountEl.style.color = 'var(--text3)';
      }
    });
  }


  // ── 9. PASSWORD STRENGTH METER ───────────────────────────
  var pwdInput = document.getElementById('password');
  var strengthBar = document.getElementById('strength-bar');
  if (pwdInput && strengthBar) {
    pwdInput.addEventListener('input', function () {
      var val = pwdInput.value;
      var score = 0;
      if (val.length >= 6) score++;
      if (val.length >= 10) score++;
      if (/[A-Z]/.test(val)) score++;
      if (/[0-9]/.test(val)) score++;
      if (/[^A-Za-z0-9]/.test(val)) score++;

      var pct = (score / 5 * 100) + '%';
      var color = score <= 1 ? 'var(--pink)' : score <= 3 ? 'var(--amber)' : 'var(--green)';
      strengthBar.style.width = pct;
      strengthBar.style.background = color;
    });
  }


  // ── 10. TABLE STATUS FILTER ──────────────────────────────
  var filterPills = document.querySelectorAll('.filter-pill[data-filter]');
  if (filterPills.length) {
    filterPills.forEach(function (pill) {
      pill.addEventListener('click', function () {
        filterPills.forEach(function (p) { p.classList.remove('active'); });
        pill.classList.add('active');
        var filter = pill.getAttribute('data-filter');
        var rows = document.querySelectorAll('tbody tr[data-status]');
        rows.forEach(function (row) {
          if (filter === 'all' || row.getAttribute('data-status') === filter) {
            row.style.display = '';
          } else {
            row.style.display = 'none';
          }
        });
      });
    });
  }


  // ── 11. SEARCH FILTER ────────────────────────────────────
  var searchInput = document.getElementById('search-input');
  if (searchInput) {
    searchInput.addEventListener('input', function () {
      var query = searchInput.value.toLowerCase();
      var rows = document.querySelectorAll('tbody tr');
      rows.forEach(function (row) {
        var text = row.textContent.toLowerCase();
        row.style.display = text.includes(query) ? '' : 'none';
      });
    });
  }


  // ── 12. CONFIRM MODAL ────────────────────────────────────
  var modal = document.getElementById('confirm-modal');
  var modalTitle = document.getElementById('modal-title');
  var modalMsg = document.getElementById('modal-msg');
  var modalYes = document.getElementById('modal-yes');
  var modalNo = document.getElementById('modal-no');
  var pendingForm = null;

  function openModal(title, msg, form) {
    if (!modal) return;
    if (modalTitle) modalTitle.textContent = title;
    if (modalMsg) modalMsg.textContent = msg;
    pendingForm = form;
    modal.classList.add('open');
  }

  if (modalNo) {
    modalNo.addEventListener('click', function () {
      modal.classList.remove('open');
      pendingForm = null;
    });
  }
  if (modalYes) {
    modalYes.addEventListener('click', function () {
      modal.classList.remove('open');
      if (pendingForm) pendingForm.submit();
    });
  }
  if (modal) {
    modal.addEventListener('click', function (e) {
      if (e.target === modal) { modal.classList.remove('open'); pendingForm = null; }
    });
  }

  document.querySelectorAll('.confirm-approve').forEach(function (btn) {
    btn.addEventListener('click', function (e) {
      e.preventDefault();
      var form = btn.closest('form');
      openModal('Approve Leave ✓', 'Are you sure you want to approve this leave request?', form);
    });
  });

  document.querySelectorAll('.confirm-reject').forEach(function (btn) {
    btn.addEventListener('click', function (e) {
      e.preventDefault();
      var form = btn.closest('form');
      openModal('Reject Leave ✗', 'Are you sure you want to reject this leave request?', form);
    });
  });


  // ── 13. TOAST NOTIFICATIONS ──────────────────────────────
  var toast = document.getElementById('toast');
  function showToast(message, type) {
    if (!toast) return;
    toast.textContent = (type === 'success' ? '✓  ' : '✕  ') + message;
    toast.className = 'show ' + type;
    setTimeout(function () { toast.classList.remove('show'); }, 3500);
  }

  var params = new URLSearchParams(window.location.search);
  if (params.get('success') === 'true') {
    showToast('Leave request submitted successfully!', 'success');
  } else if (params.get('success') === 'registered') {
    showToast('Account created! Please sign in.', 'success');
  } else if (params.get('error')) {
    showToast('Something went wrong. Please try again.', 'error');
  }


  // ── 14. SIDEBAR TOGGLE ───────────────────────────────────
  var hamburger = document.getElementById('hamburger');
  var sidebar = document.getElementById('sidebar');
  if (hamburger && sidebar) {
    hamburger.addEventListener('click', function () {
      sidebar.classList.toggle('open');
    });
  }


  // ── 15. SCROLL PROGRESS BAR ──────────────────────────────
  var progressBar = document.getElementById('scroll-progress');
  if (progressBar) {
    window.addEventListener('scroll', function () {
      var scrolled = (window.scrollY / (document.documentElement.scrollHeight - window.innerHeight)) * 100;
      progressBar.style.width = Math.min(scrolled, 100) + '%';
    });
  }


  // ── LEAVE TYPE PILL SELECTION ────────────────────────────
  document.querySelectorAll('.leave-type-pill').forEach(function (pill) {
    pill.addEventListener('click', function () {
      document.querySelectorAll('.leave-type-pill').forEach(function (p) { p.classList.remove('selected'); });
      pill.classList.add('selected');
      var leaveTypeInput = document.getElementById('leaveType');
      if (leaveTypeInput) leaveTypeInput.value = pill.getAttribute('data-type');
    });
  });


  // ── FORM SUBMIT LOADING STATE ────────────────────────────
  document.querySelectorAll('form').forEach(function (form) {
    form.addEventListener('submit', function () {
      var btn = form.querySelector('.btn-primary');
      if (btn) btn.classList.add('loading');
    });
  });

});
