// ─── COUNT UP ANIMATION ───
function countUp(el) {
  const target = parseInt(el.dataset.target || el.textContent, 10);
  if (isNaN(target)) return;
  const duration = 1000;
  const step = target / (duration / 16);
  let current = 0;
  const timer = setInterval(() => {
    current += step;
    if (current >= target) {
      el.textContent = target.toLocaleString();
      clearInterval(timer);
    } else {
      el.textContent = Math.floor(current).toLocaleString();
    }
  }, 16);
}

document.querySelectorAll('.stat-value[data-target]').forEach(countUp);

// ─── SLIDE PANEL ───
function openPanel(panelId) {
  document.getElementById(panelId).classList.add('open');
  document.getElementById(panelId + '-overlay').classList.add('open');
  document.body.style.overflow = 'hidden';
}

function closePanel(panelId) {
  document.getElementById(panelId).classList.remove('open');
  document.getElementById(panelId + '-overlay').classList.remove('open');
  document.body.style.overflow = '';
}

// ─── BOOK SEARCH FILTER ───
const searchInput = document.getElementById('book-search');
if (searchInput) {
  searchInput.addEventListener('input', function () {
    const q = this.value.toLowerCase();
    document.querySelectorAll('.book-row').forEach(row => {
      const text = row.textContent.toLowerCase();
      row.style.display = text.includes(q) ? '' : 'none';
    });
  });
}

// ─── MEMBER SEARCH FILTER ───
const memberSearch = document.getElementById('member-search');
if (memberSearch) {
  memberSearch.addEventListener('input', function () {
    const q = this.value.toLowerCase();
    document.querySelectorAll('.member-row').forEach(row => {
      const text = row.textContent.toLowerCase();
      row.style.display = text.includes(q) ? '' : 'none';
    });
  });
}

// ─── CONFIRM DIALOGS ───
function confirmDelete(formId, message) {
  if (confirm(message || 'Are you sure?')) {
    document.getElementById(formId).submit();
  }
}

// ─── ACTIVE NAV ───
const currentPath = window.location.pathname;
document.querySelectorAll('.nav-item').forEach(item => {
  const href = item.getAttribute('href');
  if (href && currentPath.includes(href)) {
    item.classList.add('active');
  }
});

// ─── BOOK SPINE COLORS ───
function hashColor(str) {
  const colors = [
    ['#6C3FFF33','#A87BFF'],
    ['#FF2F5B22','#FF6B9D'],
    ['#00FFB322','#7BFFCC'],
    ['#FFB30022','#FFD07B'],
    ['#3F9FFF22','#7BBFFF'],
    ['#FF6B3F22','#FFAA7B'],
  ];
  let hash = 0;
  for (let i = 0; i < str.length; i++) hash = str.charCodeAt(i) + ((hash << 5) - hash);
  return colors[Math.abs(hash) % colors.length];
}

document.querySelectorAll('.book-spine').forEach(spine => {
  const title = spine.dataset.title || spine.textContent;
  const [bg, text] = hashColor(title);
  spine.style.background = bg;
  spine.style.color = text;
});

// ─── AUTO DISMISS ALERTS ───
document.querySelectorAll('.alert[data-autodismiss]').forEach(alert => {
  setTimeout(() => {
    alert.style.opacity = '0';
    alert.style.transition = 'opacity 0.4s';
    setTimeout(() => alert.remove(), 400);
  }, 3000);
});
