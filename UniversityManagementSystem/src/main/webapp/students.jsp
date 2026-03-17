<%@ include file="includes/header.jsp" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<style>
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}
.page-title {
    font-size: 2rem;
}
.table-container {
    background-color: var(--card-bg);
    border: 1px solid var(--border-light);
    border-radius: 14px;
    overflow: hidden;
}
table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    padding: 16px 24px;
    text-align: left;
    border-bottom: 1px solid var(--border-light);
}
th {
    background-color: rgba(255,255,255,0.02);
    font-family: 'Syne', sans-serif;
    color: var(--text-muted);
    font-weight: 600;
}
tr:hover {
    background-color: rgba(255,255,255,0.02);
}
.empty-state {
    padding: 60px 20px;
    text-align: center;
    color: var(--text-muted);
}
</style>

<div class="container">
    <div class="page-header">
        <h1 class="page-title heading-font">Student Directory</h1>
        <a href="students?action=new" class="btn btn-primary">+ Add New Student</a>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Email Address</th>
                    <th>Course Code</th>
                    <th>Year</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty listStudent}">
                        <tr>
                            <td colspan="5" class="empty-state">No students found. Add one to get started.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="student" items="${listStudent}">
                            <tr>
                                <td>#<c:out value="${student.id}" /></td>
                                <td style="font-weight: 500; color: #fff;"><c:out value="${student.fullName}" /></td>
                                <td><c:out value="${student.email}" /></td>
                                <td><span style="background: rgba(108, 99, 255, 0.15); color: var(--purple-alt); padding: 4px 10px; border-radius: 6px; font-size: 0.85rem;"><c:out value="${student.course}" /></span></td>
                                <td><c:out value="${student.enrollmentYear}" /></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="includes/footer.jsp" %>
