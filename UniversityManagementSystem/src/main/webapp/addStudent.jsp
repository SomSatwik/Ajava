<%@ include file="includes/header.jsp" %>
<style>
.form-container {
    background-color: var(--card-bg);
    border: 1px solid var(--border-light);
    border-radius: 14px;
    padding: 40px;
    max-width: 600px;
    margin: 40px auto;
}
.page-title {
    text-align: center;
    font-size: 2rem;
    margin-bottom: 30px;
}
.form-group {
    margin-bottom: 24px;
}
.form-group label {
    display: block;
    margin-bottom: 8px;
    color: var(--text-muted);
    font-size: 0.95rem;
}
.form-control {
    width: 100%;
    padding: 12px 16px;
    background-color: rgba(0,0,0,0.2);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 8px;
    color: #fff;
    font-family: inherit;
    font-size: 1rem;
    transition: all 0.2s;
}
.form-control:focus {
    outline: none;
    border-color: var(--purple-main);
    box-shadow: 0 0 0 2px rgba(108, 99, 255, 0.2);
}
.form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 16px;
    margin-top: 32px;
}
</style>

<div class="container">
    <div class="form-container">
        <h1 class="page-title heading-font">Add New Student</h1>
        
        <form action="students" method="post">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" class="form-control" required placeholder="e.g. Jane Doe">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" required placeholder="name@university.edu">
            </div>
            
            <div class="form-group">
                <label for="course">Course Code</label>
                <input type="text" id="course" name="course" class="form-control" required placeholder="e.g. CS-101">
            </div>
            
            <div class="form-group">
                <label for="enrollmentYear">Enrollment Year</label>
                <input type="number" id="enrollmentYear" name="enrollmentYear" class="form-control" required value="2026" min="1900" max="2100">
            </div>
            
            <div class="form-actions">
                <a href="students" class="btn btn-ghost">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Student</button>
            </div>
        </form>
    </div>
</div>
<%@ include file="includes/footer.jsp" %>
