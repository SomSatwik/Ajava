<%@ include file="includes/header.jsp" %>
<style>
/* Hero Section */
.hero {
    background-color: var(--card-bg);
    border: 1px solid var(--border-light);
    border-radius: 20px;
    margin: 40px auto;
    position: relative;
    overflow: hidden;
    padding: 60px 40px;
    text-align: center;
    box-shadow: 0 20px 40px rgba(0,0,0,0.5);
}

.hero-blob {
    position: absolute;
    top: -50%;
    left: -20%;
    width: 65%;
    height: 200%;
    background-color: var(--purple-main);
    border-radius: 40% 60% 70% 30% / 40% 50% 60% 50%;
    transform: rotate(-15deg);
    z-index: 0;
    opacity: 0.9;
}

.hero-content {
    position: relative;
    z-index: 10;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.live-badge {
    background-color: var(--card-badge);
    border: 1px solid rgba(108, 99, 255, 0.3);
    padding: 6px 16px;
    border-radius: 30px;
    font-family: monospace;
    font-size: 0.85rem;
    color: var(--accent-green);
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 24px;
    letter-spacing: 1px;
}

.hero-title {
    font-size: clamp(3rem, 5vw, 68px);
    line-height: 1.1;
    margin-bottom: 20px;
    color: var(--text-main);
    font-weight: 800;
}

.hero-title .highlight {
    color: var(--purple-main);
}

.hero-subtitle {
    font-size: 1.2rem;
    color: var(--text-muted);
    max-width: 600px;
    margin-bottom: 40px;
}

.hero-actions {
    display: flex;
    gap: 16px;
    justify-content: center;
}

/* Stats Row */
.stats-row {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    margin-bottom: 60px;
}

.stat-card {
    background-color: var(--card-bg);
    border: 1px solid var(--border-light);
    border-radius: 14px;
    padding: 24px;
    position: relative;
    display: flex;
    align-items: center;
    overflow: hidden;
}

.stat-bar {
    position: absolute;
    left: 20px;
    width: 4px;
    height: 30px;
    border-radius: 4px;
}

.stat-content {
    margin-left: 20px;
    padding-left: 16px;
}

.stat-value {
    font-size: 2rem;
    font-weight: 700;
    color: #fff;
    line-height: 1;
    margin-bottom: 8px;
    font-family: 'Syne', sans-serif;
}

.stat-label {
    color: var(--text-muted);
    font-size: 0.85rem;
}

/* Features */
.features-section {
    margin-bottom: 80px;
}

.section-title {
    text-align: center;
    font-size: 2.5rem;
    margin-bottom: 10px;
}

.section-subtitle {
    text-align: center;
    color: var(--text-muted);
    margin-bottom: 40px;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}

.feature-card {
    background-color: var(--card-bg);
    border: 1px solid var(--border-light);
    border-radius: 14px;
    padding: 24px;
    position: relative;
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.feature-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
}

.feature-title {
    font-size: 1.1rem;
    font-weight: 700;
    color: #fff;
    margin-bottom: 10px;
}

.feature-desc {
    color: var(--text-muted);
    font-size: 0.9rem;
    line-height: 1.5;
}

.feature-line {
    position: absolute;
    bottom: 0;
    left: 10%;
    right: 10%;
    height: 2px;
}

@media (max-width: 1024px) {
    .stats-row, .features-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}
@media (max-width: 640px) {
    .stats-row, .features-grid {
        grid-template-columns: 1fr;
    }
    .hero-actions {
        flex-direction: column;
    }
    .hero-blob {
        left: -50%;
        width: 150%;
        transform: rotate(-10deg);
    }
}
</style>

<div class="container">
    <div class="hero">
        <div class="hero-blob"></div>
        <div class="hero-content">
            <div class="live-badge">
                <span style="color: var(--accent-green);">&#9679;</span> LIVE SYSTEM
            </div>
            <h1 class="hero-title heading-font">
                University Management <br>
                <span class="highlight">System</span>
            </h1>
            <p class="hero-subtitle">Complete Student Management Solution — Streamlined, Powerful, Modern</p>
            <div class="hero-actions">
                <a href="students" class="btn btn-primary">&#9654; View Students</a>
                <a href="addStudent.jsp" class="btn btn-dark">+ Add Student</a>
            </div>
        </div>
    </div>

    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-bar" style="background-color: var(--purple-main);"></div>
            <div class="stat-content">
                <div class="stat-value">2,847</div>
                <div class="stat-label">Enrolled Students</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-bar" style="background-color: var(--accent-pink);"></div>
            <div class="stat-content">
                <div class="stat-value">142</div>
                <div class="stat-label">Active Courses</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-bar" style="background-color: var(--accent-green);"></div>
            <div class="stat-content">
                <div class="stat-value">38</div>
                <div class="stat-label">Departments</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-bar" style="background-color: var(--accent-amber);"></div>
            <div class="stat-content">
                <div class="stat-value">99.8%</div>
                <div class="stat-label">Uptime</div>
            </div>
        </div>
    </div>

    <div class="features-section">
        <h2 class="section-title heading-font">System Features</h2>
        <p class="section-subtitle">Everything you need to manage your university</p>
        
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon" style="background-color: rgba(108, 99, 255, 0.2);">
                    <div style="width: 20px; height: 20px; background-color: var(--purple-main); border-radius: 4px;"></div>
                </div>
                <h3 class="feature-title">Student Records</h3>
                <p class="feature-desc">Full CRUD operations on student data</p>
                <div class="feature-line" style="background: linear-gradient(90deg, transparent, var(--purple-main), transparent);"></div>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon" style="background-color: rgba(255, 107, 157, 0.2);">
                    <div style="width: 20px; height: 20px; background-color: var(--accent-pink); border-radius: 4px;"></div>
                </div>
                <h3 class="feature-title">Course Management</h3>
                <p class="feature-desc">Manage courses, credits & schedules</p>
                <div class="feature-line" style="background: linear-gradient(90deg, transparent, var(--accent-pink), transparent);"></div>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon" style="background-color: rgba(0, 212, 170, 0.2);">
                    <div style="width: 20px; height: 20px; background-color: var(--accent-green); border-radius: 4px;"></div>
                </div>
                <h3 class="feature-title">Department Control</h3>
                <p class="feature-desc">Organize faculties and departments</p>
                <div class="feature-line" style="background: linear-gradient(90deg, transparent, var(--accent-green), transparent);"></div>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon" style="background-color: rgba(245, 158, 11, 0.2);">
                    <div style="width: 20px; height: 20px; background-color: var(--accent-amber); border-radius: 4px;"></div>
                </div>
                <h3 class="feature-title">Live Database</h3>
                <p class="feature-desc">Real-time sync with MySQL backend</p>
                <div class="feature-line" style="background: linear-gradient(90deg, transparent, var(--accent-amber), transparent);"></div>
            </div>
        </div>
    </div>
</div>
<%@ include file="includes/footer.jsp" %>
