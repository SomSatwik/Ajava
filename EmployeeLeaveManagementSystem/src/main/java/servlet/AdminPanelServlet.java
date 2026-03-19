package servlet;

import dao.EmployeeDao;
import dao.LeaveDao;
import model.Employee;
import model.LeaveRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AdminPanelServlet extends HttpServlet {

    private final LeaveDao leaveDao = new LeaveDao();
    private final EmployeeDao employeeDao = new EmployeeDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employee") == null) {
            response.sendRedirect("login");
            return;
        }

        Employee employee = (Employee) session.getAttribute("employee");
        if (!"ADMIN".equals(employee.getRole())) {
            response.sendRedirect("dashboard");
            return;
        }

        List<LeaveRequest> allLeaves = leaveDao.getAllLeaves();
        long pendingCount = leaveDao.countByStatus("PENDING");
        long approvedCount = leaveDao.countByStatus("APPROVED");
        long rejectedCount = leaveDao.countByStatus("REJECTED");
        long totalRequests = pendingCount + approvedCount + rejectedCount;

        List<Employee> allEmployees = employeeDao.getAllEmployees();
        int employeeCount = allEmployees != null ? allEmployees.size() : 0;

        request.setAttribute("allLeaves", allLeaves);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);
        request.setAttribute("totalRequests", totalRequests);
        request.setAttribute("employeeCount", employeeCount);

        request.getRequestDispatcher("adminPanel.jsp").forward(request, response);
    }
}
