package servlet;

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

public class DashboardServlet extends HttpServlet {

    private final LeaveDao leaveDao = new LeaveDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employee") == null) {
            response.sendRedirect("login");
            return;
        }

        Employee employee = (Employee) session.getAttribute("employee");

        if ("ADMIN".equals(employee.getRole())) {
            response.sendRedirect("adminPanel");
            return;
        }

        int empId = employee.getId();

        List<LeaveRequest> leaves = leaveDao.getLeavesByEmployee(empId);
        long totalLeaves = leaves != null ? leaves.size() : 0;
        long pendingCount = leaveDao.countByStatusAndEmployee("PENDING", empId);
        long approvedCount = leaveDao.countByStatusAndEmployee("APPROVED", empId);
        long rejectedCount = leaveDao.countByStatusAndEmployee("REJECTED", empId);

        request.setAttribute("leaves", leaves);
        request.setAttribute("totalLeaves", totalLeaves);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
