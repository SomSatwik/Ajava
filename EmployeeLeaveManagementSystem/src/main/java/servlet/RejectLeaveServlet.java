package servlet;

import dao.LeaveDao;
import model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class RejectLeaveServlet extends HttpServlet {

    private final LeaveDao leaveDao = new LeaveDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        int leaveId = Integer.parseInt(request.getParameter("leaveId"));
        leaveDao.updateStatus(leaveId, "REJECTED");

        response.sendRedirect("adminPanel");
    }
}
